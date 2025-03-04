// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/bindings/biending.dart';
import 'package:storee/core/localization/changelocal.dart';
import 'package:storee/core/localization/translation.dart';
import 'package:storee/core/services/services.dart';
import 'package:storee/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';


// Global Supabase client instance
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register MyServices asynchronously before running the app
  await Get.putAsync(() async => await MyServices().init());

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    debug: true,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations:MyTranslation() ,
      debugShowCheckedModeBanner: false,
      title: 'StoreGo',
      locale:controller.language,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding:MyBinding() ,
      //routes: routes,
      getPages: routes,
    );
  }
}
