import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.rate,
    required this.onTap,
    required this.onAddToCart,
    required this.onAddToFavorite,
    required this.icon,
  });
  final String imageUrl;
  final String productName;
  final String price;
  final String rate;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 300,
      decoration: BoxDecoration(
        color: AppStyle.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppStyle.lightBlue100.withValues(alpha: 0.5),
            blurRadius: 5,
            offset: Offset(0, 2),
            spreadRadius: 1,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 150,
              height: 95,
              color: AppStyle.lightBlue900,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.values[1],
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Image.network(imageUrl, height: 90),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: onAddToFavorite,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppStyle.background,
                            ),
                            child: icon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: AppStyle.placeholderStyle.copyWith(
                      color: AppStyle.darkBlue900,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        color: AppStyle.darkBlue900,
                        size: 18,
                      ),
                      Text(
                        rate,
                        style: AppStyle.placeholderStyle.copyWith(
                          color: AppStyle.darkBlue900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: AppStyle.placeholderStyle.copyWith(
                      color: AppStyle.darkBlue900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 25,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyle.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppStyle.lightBlue100, width: 2),
                  ),
                ),
                onPressed: onAddToCart,
                child: Text(
                  'Add',
                  style: AppStyle.button.copyWith(color: AppStyle.lightBlue100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
