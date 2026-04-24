import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/feature/cart/presentation/mangement/cubit/cart_cubit.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_cubit.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';
import 'package:marketi/feature/home/presentation/mangement/cubit/home_cubit.dart';
import 'package:marketi/feature/home/presentation/ui/pages/best_for_you_screen.dart';
import 'package:marketi/feature/home/presentation/ui/pages/brands_screen.dart';
import 'package:marketi/feature/home/presentation/ui/pages/buy_again_screen.dart';
import 'package:marketi/feature/home/presentation/ui/pages/categories_screeen.dart';
import 'package:marketi/feature/home/presentation/ui/pages/item_details_screen.dart';
import 'package:marketi/feature/home/presentation/ui/pages/popular_products_screen.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/category_item.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/custom_searsh.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/loading_widget.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/product_item.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/tittles_in_home.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/user_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final name = PreferenceManager.instance.getString('name') ?? 'User';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(getIt<HomeRepo>())
            ..getProducts()
            ..getCategories()
            ..getBrands(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          final cartCubit = context.read<CartCubit>();
          final favotiteCubit = context.read<FavoriteCubit>();
          if (state is HomeLoading) {
            return LoadingWidget();
          } else if (state is HomeFailure) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage, style: AppStyle.title),
              ),
            );
          }
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          UserImage(),
                          SizedBox(width: 10),
                          Text(
                            'Hi, $name',
                            style: AppStyle.title.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Icon(
                                Icons.notifications_none_outlined,
                                color: AppStyle.lightBlue100,
                                size: 35,
                              ),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      CustomSearch(
                        controller: _searchController,
                        onSubmitted: (vaiue) {
                          homeCubit.searchProducts(vaiue);
                        },
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/images/ww.jpg",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 15),
                      TittlesInHome(
                        tittle: "Popular Products",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PopularProductsScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 190,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final product = homeCubit.products[index];
                            return BlocBuilder<UiCubit, UiState>(
                              builder: (context, uiState) {
                                return ProductItem(
                                  imageUrl: product.images.first,
                                  productName: product.brand,
                                  price: product.price.toString(),
                                  rate: product.rating.toString(),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ItemDetailsScreen(
                                          productName: product.brand,
                                          productDescription:
                                              product.description,
                                          productPrice: product.price
                                              .toString(),
                                          productImage: product.images.first,
                                          productRating: product.rating
                                              .toString(),
                                          onAddToCart: () {
                                            cartCubit.addToCart(
                                              product.id.toString(),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onAddToCart: () {
                                    cartCubit.addToCart(product.id.toString());
                                  },
                                  onAddToFavorite: () {
                                    context.read<UiCubit>().toggleFavorite(
                                      product.id,
                                    ); // ✅
                                    favotiteCubit.addToFavorite(
                                      product.id.toString(),
                                    );
                                  },
                                  icon: Icon(
                                    uiState.favorites[product.id] ==
                                            true // ✅
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 16,
                                    color:
                                        uiState.favorites[product.id] ==
                                            true // ✅
                                        ? Colors.red
                                        : AppStyle.darkBlue900,
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: homeCubit.products.length,
                        ),
                      ),
                      SizedBox(height: 15),
                      TittlesInHome(
                        tittle: "Categories",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 300,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                              ),
                          itemBuilder: (context, index) {
                            final category = homeCubit.categories[index];
                            return CategoryItem(
                              imagePath: category.image,
                              name: category.name,
                            );
                          },
                          itemCount: homeCubit.categories.length,
                        ),
                      ),
                      SizedBox(height: 15),
                      TittlesInHome(
                        tittle: "Best For You",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BestForYouScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 190,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final product = homeCubit.products[index];
                            return BlocBuilder<UiCubit, UiState>(
                              builder: (context, uiState) {
                                return ProductItem(
                                  imageUrl: product.images.first,
                                  productName: product.brand,
                                  price: product.price.toString(),
                                  rate: product.rating.toString(),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ItemDetailsScreen(
                                          productName: product.brand,
                                          productDescription:
                                              product.description,
                                          productPrice: product.price
                                              .toString(),
                                          productImage: product.images.first,
                                          productRating: product.rating
                                              .toString(),
                                          onAddToCart: () {
                                            cartCubit.addToCart(
                                              product.id.toString(),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onAddToCart: () {
                                    cartCubit.addToCart(product.id.toString());
                                  },
                                  onAddToFavorite: () {
                                    context.read<UiCubit>().toggleFavorite(
                                      product.id,
                                    ); // ✅
                                    favotiteCubit.addToFavorite(
                                      product.id.toString(),
                                    );
                                  },
                                  icon: Icon(
                                    uiState.favorites[product.id] ==
                                            true // ✅
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 16,
                                    color:
                                        uiState.favorites[product.id] ==
                                            true // ✅
                                        ? Colors.red
                                        : AppStyle.darkBlue900,
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: homeCubit.products.length,
                        ),
                      ),
                      SizedBox(height: 15),
                      TittlesInHome(
                        tittle: "Brands",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrandsScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 140,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final brand = homeCubit.brands[index];
                            return Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppStyle.lightBlue700,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      brand.emoji,
                                      style: TextStyle(fontSize: 40),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      brand.name,
                                      style: AppStyle.title.copyWith(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: homeCubit.brands.length,
                        ),
                      ),
                      SizedBox(height: 15),
                      TittlesInHome(
                        tittle: "Buy Again",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuyAgainScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 190,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final product = homeCubit.products[index];
                            return BlocBuilder<UiCubit, UiState>(
                              builder: (context, uiState) {
                                return ProductItem(
                                  imageUrl: product.images.first,
                                  productName: product.brand,
                                  price: product.price.toString(),
                                  rate: product.rating.toString(),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ItemDetailsScreen(
                                          productName: product.brand,
                                          productDescription:
                                              product.description,
                                          productPrice: product.price
                                              .toString(),
                                          productImage: product.images.first,
                                          productRating: product.rating
                                              .toString(),
                                          onAddToCart: () {
                                            cartCubit.addToCart(
                                              product.id.toString(),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onAddToCart: () {
                                    cartCubit.addToCart(product.id.toString());
                                  },
                                  onAddToFavorite: () {
                                    context.read<UiCubit>().toggleFavorite(
                                      product.id,
                                    ); // ✅
                                    favotiteCubit.addToFavorite(
                                      product.id.toString(),
                                    );
                                  },
                                  icon: Icon(
                                    uiState.favorites[product.id] ==
                                            true // ✅
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 16,
                                    color:
                                        uiState.favorites[product.id] ==
                                            true // ✅
                                        ? Colors.red
                                        : AppStyle.darkBlue900,
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: homeCubit.products.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
