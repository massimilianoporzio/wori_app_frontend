import 'package:flutter/material.dart';

abstract class Utils {
  static ImageCache get imageCache => PaintingBinding.instance.imageCache;

  static NetworkImage getImageProvider(url) {
    imageCache.clear();
    return NetworkImage(url);
  }
}
