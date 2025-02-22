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

// Global Supabase client instance
final supabase = Supabase.instance.client;

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  // Initialize Supabase
  await Supabase.initialize(
      url: 'https://zzklwsqmodwlpboowpym.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2x3c3Ftb2R3bHBib293cHltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk1NTQ1ODgsImV4cCI6MjA1NTEzMDU4OH0.ESdYUM-R3L2iv6QIMQuCJRwzYK5mP6_loy2OOSUW2dI',
      debug: true);

  // Initialize deep link handling

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
