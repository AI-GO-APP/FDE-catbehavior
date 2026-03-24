import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  bool enablePreview = kDebugMode;

  // 在網頁版中，若進入的不是後台 /admin 路徑，則強制開啟 DevicePreview 手機殼以便向客戶展示
  if (kIsWeb) {
    if (!Uri.base.toString().contains('/admin')) {
      enablePreview = true;
    } else {
      enablePreview = false;
    }
  }

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: enablePreview,
        builder: (context) => const CatChatApp(),
      ),
    ),
  );
}
