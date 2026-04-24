import 'package:flutter/material.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppStyle.lightBlue900,
      highlightColor: AppStyle.background,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.all(10),
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppStyle.lightBlue900,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
