import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:oxoo/bloc/bloc.dart';
import 'package:oxoo/colors.dart';
import 'package:oxoo/config.dart';
import 'package:oxoo/pages/CoontinuePage.dart';
import 'package:oxoo/pages/SwipePage.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
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
import 'package:oxoo/screen/auth/signIn_screen.dart';

class MyApp extends StatefulWidget {
  static final String route = "/MyApp";

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var appModeBox = Hive.box('appModeBox');
  var onboard = Hive.box('onboard');
  var login = Hive.box('login');
  static bool? isDark = true;
  static bool? isFirstTime = true;
  static bool? isLogin = true;
  VideoPlayerController? _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();

    isDark = appModeBox.get('isDark');
    if (isDark == null) {
      appModeBox.put('isDark', true);
    }
    isFirstTime = onboard.get('isFirstTime');
    if (isFirstTime == null) {
      onboard.put('isFirstTime', true);
    }
    isLogin = login.get('isLogin');
    print("lgoung$isLogin");
    if (isLogin == null) {
      login.put('isLogin', false);
    }
    _controller = VideoPlayerController.asset(
      "assets/jalsasplash.mp4",
    );

    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.play();
    initOneSignal();
  }

  @override
  Widget build(BuildContext context) {
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
              return MaterialApp(
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

                home: FlutterSplashScreen.fadeIn(
                  childWidget:
                      //  AspectRatio(
                      //   aspectRatio: 0.48,

                      //   // Use the VideoPlayer widget to display the video.
                      //   child: VideoPlayer(_controller!),
                      // ),
                      Image.asset(
                    "assets/yellow.jpeg",
                    width: 400,
                    height: 400,
                    fit: BoxFit.fitHeight,
                  ),
                  backgroundColor: Color(0xff3F3735),
                  nextScreen: child!,
                  //    duration: Duration(seconds: 6),
                ),
              );
            },
            child: RenderFirstScreen(),
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
  static final String route = "/RenderFirstScreen";
  bool? isMandatoryLogin = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('login').listenable(),
      builder: (context, dynamic box, widget) {
        isMandatoryLogin = box.get('isLogin');
        printLog("isMandatoryLogin " + "$isMandatoryLogin");
        return renderFirstScreen(isMandatoryLogin!);
      },
    );
  }

  Widget renderFirstScreen(
    bool isMandatoryLogin,
  ) {
    // print(isMandatoryLogin);
    // bool isLogin = false;
    if (isMandatoryLogin) {
      return LandingScreen();
    } else {
      return
          // ValueListenableBuilder(
          //     valueListenable: Hive.box('login').listenable(),
          //     builder: (context, dynamic box, widget) {
          //       isLogin = box.get('isLogin');
          //       if (isLogin == null) {
          //         box.put('isLogin', false);
          //       }
          //       // print("lgoing $isLogin");
          //       return isLogin ? LandingScreen() :
          LoginPage();
      //     });
    }
  }
}
