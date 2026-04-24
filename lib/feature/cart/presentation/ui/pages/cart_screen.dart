import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/services/stripe_payment/payment_maneger.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/cart/presentation/mangement/cubit/cart_cubit.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_cubit.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/loading_widget.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/user_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getCart();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [UserImage()],
        actionsPadding: const EdgeInsets.only(right: 16),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("Products On Cart", style: AppStyle.title)],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return LoadingWidget();
                  }
                  if (state is CartFailure) {
                    return Center(child: Text(state.errorMessage));
                  }
                  final cartCubit = context.read<CartCubit>();
                  final favoriteCubit = context.read<FavoriteCubit>();
                  if (cartCubit.products.isEmpty) {
                    return Center(
                      child: Text("Cart Empty", style: AppStyle.title),
                    );
                  }
                  return ListView.separated(
                    itemCount: cartCubit.products.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final product = cartCubit.products[index];
                      return Container(
                        height: 160,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 15,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppStyle.background,
                          border: Border.all(color: AppStyle.lightBlue700),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyle.lightBlue100.withValues(
                                alpha: 20,
                              ),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              product.product.images.first,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.product.brand,
                                          style: AppStyle.title2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      BlocBuilder<UiCubit, UiState>(
                                        builder: (context, uiState) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<UiCubit>()
                                                  .toggleFavorite(
                                                    product.product.id,
                                                  );
                                              favoriteCubit.addToFavorite(
                                                product.product.id.toString(),
                                              );
                                            },
                                            icon: Icon(
                                              uiState.favorites[product
                                                          .product
                                                          .id] ==
                                                      true
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 24,
                                              color:
                                                  uiState.favorites[product
                                                          .product
                                                          .id] ==
                                                      true
                                                  ? Colors.red
                                                  : AppStyle.darkBlue900,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        product.product.price.toString(),
                                        style: AppStyle.title2,
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(Icons.star_border),
                                          Text(
                                            product.product.rating.toString(),
                                            style: AppStyle.title2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (product.quantity == 1) {
                                            context
                                                .read<CartCubit>()
                                                .removeFromCart(
                                                  product.product.id.toString(),
                                                );
                                          } else {
                                            context
                                                .read<CartCubit>()
                                                .decrementQuantity(
                                                  product.product.id.toString(),
                                                );
                                          }
                                        },
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: AppStyle.lightBlue900,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            product.quantity == 1
                                                ? Icons.delete
                                                : Icons.remove,
                                            color: product.quantity == 1
                                                ? Colors.red
                                                : AppStyle.lightBlue100,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        product.quantity.toString(),
                                        style: AppStyle.title2,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<CartCubit>()
                                              .incrementQuantity(
                                                product.product.id.toString(),
                                              );
                                        },
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: AppStyle.lightBlue900,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: AppStyle.lightBlue100,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartCubit = context.read<CartCubit>();
                final total = cartCubit.products.fold<double>(
                  0.0,
                  (sum, item) => sum + (item.product.price * item.quantity),
                );
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Price", style: AppStyle.title),

                        Text(
                          "\$ ${total.toStringAsFixed(2)}",
                          style: AppStyle.title,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      onPressed: () {
                        PaymentManager.makePayment(total.toInt(), "USD");
                      },
                      buttonTitle: "Checkout",
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
