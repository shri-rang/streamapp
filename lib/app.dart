import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:oxoo/bloc/bloc.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/config.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/pages/SwipePage.dart';
import 'package:oxoo/screen/home_screen.dart';
import 'package:oxoo/style/theme.dart';
import 'package:provider/provider.dart';
import '../../bloc/auth/registration_bloc.dart';
import '../../service/authentication_service.dart';
import 'bloc/auth/firebase_auth/firebase_auth_bloc.dart';
import 'bloc/auth/login_bloc.dart';
import 'bloc/auth/phone_auth/phone_auth_bloc.dart';
import 'constants.dart';
import 'screen/landing_screen.dart';
import 'service/get_config_service.dart';
import 'models/configuration.dart';
import 'screen/auth/auth_screen.dart';
import 'server/phone_auth_repository.dart';
import 'server/repository.dart';
import 'utils/route.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  static final String route = "/MyApp";

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var appModeBox = Hive.box('appModeBox');
  static bool? isDark = true;
  UserCredential? uid;

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark');
    if (isDark == null) {
      appModeBox.put('isDark', true);
    }

    //initOneSignal();
  }

  @override
  Widget build(BuildContext context) {
    uid = appModeBox.get("uid");
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
        Provider<GetConfigService>(
          create: (context) => GetConfigService(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeContentBloc>(
                create: (context) => HomeContentBloc(repository: Repository())),
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(Repository()),
            ),
            BlocProvider<PhoneAuthBloc>(
                create: (context) =>
                    PhoneAuthBloc(userRepository: UserRepository())),
            BlocProvider<RegistrationBloc>(
              create: (context) => RegistrationBloc(Repository()),
            ),
            BlocProvider<FirebaseAuthBloc>(
              create: (context) => FirebaseAuthBloc(Repository()),
            ),
          ],
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: '',
                routes: Routes.getRoute(),
                // You can use the library anywhere in the app even in theme
                theme: ThemeData(
                  scaffoldBackgroundColor: black,
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: AnimatedSplashScreen(
                    splash: "assets/logo.png",
                    splashIconSize: 600,
                    backgroundColor: CustomTheme.primaryColorDark,
                    nextScreen: child!),
              );
            },
            child:

                //  HomeScreen()
                RenderFirstScreen(
              uid: uid,
            ),
          )

          //  MaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   routes: Routes.getRoute(),
          //   home: RenderFirstScreen(),
          // )
          ),
    );
  }

  Future<void> initOneSignal() async {
    if (!mounted) return;
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(true);
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {});
    OneSignal.shared.setAppId(Config.oneSignalID);
    // iOS-only method to open launch URLs in Safari when set to false
    OneSignal.shared.setLaunchURLsInApp(false);
  }
}

// ignore: must_be_immutable
class RenderFirstScreen extends StatelessWidget {
  RenderFirstScreen({this.uid});
  static final String route = "/RenderFirstScreen";
  bool? isMandatoryLogin = false;
  UserCredential? uid;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ConfigurationModel>('configBox').listenable(),
      builder: (context, dynamic box, widget) {
        isMandatoryLogin = true;
        // box.get(0).appConfig.
        // box.get(0).appConfig.mandatoryLogin;
        printLog("isMandatoryLogin " + "$isMandatoryLogin");
        return renderFirstScreen(isMandatoryLogin!);
      },
    );
  }

  Widget renderFirstScreen(bool isMandatoryLogin) {
    print(isMandatoryLogin);
    if (isMandatoryLogin) {
      return LandingScreen();
    } else {
      return LandingScreen();
    }
  }
}
