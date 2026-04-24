import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:marketi/feature/cart/presentation/mangement/cubit/cart_cubit.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_cubit.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';
import 'package:marketi/feature/home/presentation/mangement/cubit/home_cubit.dart';
import 'package:marketi/feature/home/presentation/ui/pages/item_details_screen.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/custom_searsh.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/loading_widget.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/product_item.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/user_image.dart';

class BestForYouScreen extends StatelessWidget {
  BestForYouScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(getIt<HomeRepo>())..getProducts(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: ArrowBack(),
          title: const Text('Best For You'),
          actions: [UserImage()],
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSearch(controller: controller),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("All Products", style: AppStyle.title)],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final homeCubit = context.read<HomeCubit>();
                    final cartCubit = context.read<CartCubit>();
                    final favotiteCubit = context.read<FavoriteCubit>();
                    if (state is HomeLoading) {
                      return LoadingWidget();
                    } else if (state is HomeFailure) {
                      return Center(
                        child: Text(state.errorMessage, style: AppStyle.body),
                      );
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
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
                                    ); 
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
