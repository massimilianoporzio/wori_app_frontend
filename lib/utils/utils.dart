import 'package:flutter/material.dart';

abstract class Utils {
  static Image getImage(url) => Image.network(url);
}
