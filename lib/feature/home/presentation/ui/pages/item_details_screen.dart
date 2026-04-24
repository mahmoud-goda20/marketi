import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:marketi/core/widgets/custom_button.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productRating, required this.onAddToCart,
  });
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productImage;
  final String productRating;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBack(),
        title: const Text('Product Details'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(productImage, height: 250),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productName,
                  style: AppStyle.title.copyWith(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Icon(Icons.star_border, size: 20),
                    Text(
                      productRating,
                      style: AppStyle.title.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              productDescription,
              style: AppStyle.body2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              productPrice,
              style: AppStyle.title.copyWith(
                fontWeight: FontWeight.w500,
                color: AppStyle.lightBlue100,
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: onAddToCart,
              buttonTitle: 'Add to Cart',
            ),
          ],
        ),
      ),
    );
  }
}
