import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'routes/app_pages.dart';
import 'ui/theme.dart';
import 'db/app_db.dart';
import 'data/default_items.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('marketCache');
  // Register a single AppDb instance globally to avoid multiple database creations
  Get.put<AppDb>(AppDb(), permanent: true);
  // Seed default catalog items if needed
  await ensureDefaultCatalogSeeded(Get.find<AppDb>());
  runApp(const WhatIfApp());
}

class WhatIfApp extends StatelessWidget {
  const WhatIfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'What If I Invested?',
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(),
          initialRoute: AppPages.initial,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
