// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart';
import 'package:storee/routes/app_pages.dart';
import 'dart:async';

// Global Supabase client instance
final supabase = Supabase.instance.client;

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://zzklwsqmodwlpboowpym.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2x3c3Ftb2R3bHBib293cHltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk1NTQ1ODgsImV4cCI6MjA1NTEzMDU4OH0.ESdYUM-R3L2iv6QIMQuCJRwzYK5mP6_loy2OOSUW2dI',
    debug: true
  );

  // Initialize deep link handling
  await initAppLinks();

  runApp(const MyApp());
}

// Initialize and configure deep link handling
Future<void> initAppLinks() async {
  final appLinks = AppLinks();

  // Check initial deep link
  try {
    final Uri? initialLink = await appLinks.getInitialLink();
    if (initialLink != null) {
      handleDeepLink(initialLink);
    }
  } catch (e) {
    print('Error retrieving initial link: $e');
  }

  // Listen for incoming links
  appLinks.uriLinkStream.listen(
    (Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    },
    onError: (err) {
      print('Error processing link: $err');
    }
  );
}// Handle deep links with GetX navigation
void handleDeepLink(Uri uri) {
  print("Deep link received: ${uri.toString()}");
  
  if (uri.host == 'reset-callback') {
    Get.toNamed(Routes.UPDATE_PASSWORD);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StoreGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.ONBOARDING,
      getPages: AppPages.routes,
    );
  }
}