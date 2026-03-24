import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class CatChatApp extends StatelessWidget {
  const CatChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '貓談社 CatChat',
      theme: AppTheme.lightTheme,
      
      // DevicePreview 支持
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      
      // GoRouter
      routerConfig: appRouter,
    );
  }
}
