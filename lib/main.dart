import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:image_gallery/core/services/log_service.dart';
import 'package:image_gallery/ui/album/screens/home_screen.dart';
import 'package:image_gallery/utils/config/app_color.dart';
import 'package:image_gallery/utils/config/app_style.dart';
import 'package:image_gallery/utils/config/app_text.dart';
import 'package:image_gallery/utils/config/env.dart';
import 'package:image_gallery/viewmodels/app/app_cubit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  Log.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        await FlutterSplashScreen.hide();
      } catch (e) {
        Log.create(Level.info, "Error hiding splash screen: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: Env().envType == AppText().devEnv,
        title: AppText().title,
        theme: ThemeData(
          fontFamily: AppStyle().primaryFont,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor().primary),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
