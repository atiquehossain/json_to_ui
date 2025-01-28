import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? radius;
  final BoxFit? fit;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.radius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: radius,
      ),
      placeholder: (context, url) => CircleAvatar(
        radius: radius,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        child: const Icon(Icons.error),
      ),
      fit: fit ?? BoxFit.cover,
      cacheKey: imageUrl,
      maxHeightDiskCache: 1024,
      maxWidthDiskCache: 1024,
    );
  }
}