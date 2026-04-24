import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.imagePath, required this.name});
  final String imagePath;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppStyle.background,
      ),
      child: Column(
        children: [
          Expanded(child: Image.network(imagePath)),
          Text(
            name,
            style: AppStyle.body2.copyWith(color: AppStyle.darkBlue900),
          ),
        ],
      ),
    );
  }
}
