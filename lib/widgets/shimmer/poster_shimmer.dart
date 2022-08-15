import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PosterShimmer extends StatelessWidget {
  const PosterShimmer(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: 200,
            width: 130,
            // margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
          ),
        ],
      ),
    );
  }
}