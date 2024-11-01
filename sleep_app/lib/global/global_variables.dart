import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GlobalVariables {
  static Size size = const Size(393, 852);
  static CacheManager cacheManager = CacheManager(Config('customCacheKey', maxNrOfCacheObjects: 70));
}
