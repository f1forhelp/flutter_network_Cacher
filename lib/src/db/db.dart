import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_network_cacher/src/helper/string_helper.dart';

class Db {
  Db._();

  static Future<String?> getStringData({required String key}) async {
    FileInfo? fileInfo =
        await DefaultCacheManager().getFileFromCache(key, ignoreMemCache: true);
    if (fileInfo != null) {
      return await fileInfo.file.readAsString();
    } else {
      return null;
    }
  }

  static Future<String> putStringData(
      {required String uId,
      String? data,
      Duration maxAge = const Duration(days: 30)}) async {
    File file = await DefaultCacheManager().putFile(
        uId, StringHelper.stringToUnit8List(data ?? ""),
        maxAge: maxAge, eTag: uId);
    return file.readAsString();
  }

  static Future clearCache() async {
    await DefaultCacheManager().emptyCache();
  }
}
