import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trendychef/core/const/api_endpoints.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final fullUrl = baseHost + imageUrl;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromARGB(33, 236, 236, 236),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: kIsWeb
          ? Image.network(
              fullUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, _, _) =>
                  const Center(child: Icon(Icons.broken_image)),
            )
          : CachedNetworkImage(
              imageUrl: fullUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,

              errorWidget: (_, _, _) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
    );
  }
}
