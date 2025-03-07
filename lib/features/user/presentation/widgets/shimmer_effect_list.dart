import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectList extends StatelessWidget {
  const ShimmerEffectList({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
