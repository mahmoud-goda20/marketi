import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/feature/cart/presentation/mangement/cubit/cart_cubit.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_cubit.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_state.dart';
import 'package:marketi/feature/home/presentation/ui/pages/item_details_screen.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/custom_searsh.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/loading_widget.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/product_item.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/user_image.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().getFavorite();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
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
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  final favoriteCubit = context.read<FavoriteCubit>();
                  if (state is FavoriteLoading) {
                    return LoadingWidget();
                  } else if (state is FavoriteFailure) {
                    return Center(
                      child: Text(state.errorMessage, style: AppStyle.body),
                    );
                  }
                  if (favoriteCubit.products.isEmpty) {
                    return Center(
                      child: Text(
                        "No Favorite Products",
                        style: AppStyle.title,
                      ),
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
                      final product = favoriteCubit.products[index];
                      final cartCubit = context.read<CartCubit>();
                      return ProductItem(
                        imageUrl: product.product.images.first,
                        productName: product.product.brand,
                        price: product.product.price.toString(),
                        rate: product.product.rating.toString(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ItemDetailsScreen(
                                productName: product.product.brand,
                                productDescription: product.product.description,
                                productPrice: product.product.price.toString(),
                                productImage: product.product.images.first,
                                productRating: product.product.rating
                                    .toString(),
                                onAddToCart: () {
                                  cartCubit.addToCart(
                                    product.product.id.toString(),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        onAddToCart: () {
                          context.read<CartCubit>().addToCart(
                            product.product.id.toString(),
                          );
                        },
                        onAddToFavorite: () {
                          context.read<UiCubit>().toggleFavorite(
                            product.product.id,
                          );
                          favoriteCubit.removeFromFavorite(
                            product.product.id.toString(),
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 16,
                          color: AppStyle.red,
                        ),
                      );
                    },
                    itemCount: favoriteCubit.products.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
