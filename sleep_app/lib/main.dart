import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sleep_app/global/global_routes.dart';
import 'package:sleep_app/global/global_variables.dart';
import 'package:sleep_app/pages/main_page/main_page.dart';
import 'package:sleep_app/pages/signin_page/signin_page.dart';
import 'package:sleep_app/pages/status/global_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SleepAPP());
}

class SleepAPP extends StatelessWidget {
  const SleepAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: GlobalVariables.size,
      builder: (context, child) => GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: GetMaterialApp(
          theme: ThemeData(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          debugShowCheckedModeBanner: false,
          routingCallback: (route) async {
            if (route!.isBack!) {}
            if (route.current.contains('game')) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
            }
          },
          onReady: () async {
            bool back_interceptor(bool stopDefaultButtonEvent, RouteInfo info) {
              if (GetPlatform.isAndroid) {
                if (Get.currentRoute != '') {
                  if (Get.currentRoute != GlobalRoutes.main) {
                    Get.back();
                    return true;
                  } else {
                    Get.back();
                    return true;
                  }
                } else {
                  return true;
                }
              } else {
                return true;
              }
            }

            BackButtonInterceptor.add(back_interceptor);
          },
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
              child: child!,
            );
          },
          initialRoute: GlobalRoutes.signin,
          defaultTransition: GetPlatform.isAndroid ? Transition.noTransition : Transition.native,
          transitionDuration: const Duration(milliseconds: 500),
          getPages: [
            GetPage(
              name: GlobalRoutes.main,
              page: () => MainPage(),
              binding: MainPageBinding(),
            ),
            GetPage(
              name: GlobalRoutes.signin,
              page: () => SignInPage(),
              binding: MainPageBinding(),
            ),
          ],
        ),
      ),
    );
  }
}
