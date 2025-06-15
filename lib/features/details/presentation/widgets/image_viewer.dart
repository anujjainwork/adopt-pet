import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageViewer extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CustomImageViewer({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = true;
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRect(
          child: InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            minScale: 0.5,
            maxScale: 4.0,
            child:
                isNetworkImage
                    ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      placeholder:
                          (context, url) =>
                              Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                    : Image.asset(imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
