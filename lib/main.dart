import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dispatch/firebase_options.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/provider/fetch_data.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/util/notification_manager.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'view/login_page.dart';

const LINE_CHANNEL_ID = "1661481763";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String storageLocation = (await getApplicationDocumentsDirectory()).path;
  await FastCachedImageConfig.init(
      subDir: storageLocation, clearCacheAfter: const Duration(days: 15));
  UserDefault().init();
  if (kIsWeb == false) {
    await LineSDK.instance.setup(LINE_CHANNEL_ID);
    PushNotificationManager.init();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();

        serviceWorkerController.serviceWorkerClient =
            AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        );
      }
    }
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<int, Color> _primary_color = {
    50: const Color.fromRGBO(0, 99, 162, .1),
    100: const Color.fromRGBO(0, 99, 162, .2),
    200: const Color.fromRGBO(0, 99, 162, .3),
    300: const Color.fromRGBO(0, 99, 162, .4),
    400: const Color.fromRGBO(0, 99, 162, .5),
    500: const Color.fromRGBO(0, 99, 162, .6),
    600: const Color.fromRGBO(0, 99, 162, .7),
    700: const Color.fromRGBO(0, 99, 162, .8),
    800: const Color.fromRGBO(0, 99, 162, .9),
    900: const Color.fromRGBO(0, 99, 162, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => FetchData(),
          ),
        ],
        child: ScreenUtilInit(
            //minTextAdapt: true,
            splitScreenMode: true,
            designSize: const Size(411.42, 867.42),
            builder: (_, child) {
              return MaterialApp(
                title: 'Biz-Works',
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                theme: ThemeData(
                  primarySwatch: MaterialColor(0xFF0063A2, _primary_color),
                  fontFamily: 'NotoSansTC',
                ),
                builder: EasyLoading.init(builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                    child: widget!,
                  );
                }),
                home: AnimatedSplashScreen(
                    duration: 3000,
                    splash: 'assets/images/splash.png',
                    splashIconSize: 800,
                    nextScreen: const LoginPage(
                      auto_login: true,
                    ),
                    splashTransition: SplashTransition.scaleTransition,
                    pageTransitionType: PageTransitionType.fade,
                    backgroundColor: const Color(0xFF0069ab)),
              );
            }));
  }
}
