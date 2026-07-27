import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/routes/app_routes.dart';
import 'package:habit_tracker/feature/landing/presentation/pages/splash_view.dart';
import 'package:habit_tracker/injector.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await _preloadFonts();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return Injector(
          routerWidget: const MyApp(),
        );
      },
    ),
  );
}

Future<void> _preloadFonts() async {
  await Future.wait([
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(),
    ]),
  ]);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: SplashView.route,
      getPages: AppRoutes.pages,

    );
  }
}

