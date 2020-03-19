
import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/page/home/home_page.dart';
import 'package:fskymusic/page/splash_page.dart';
import 'package:fskymusic/provider/app_provider.dart';
import 'package:fskymusic/provider/play_songs_model.dart';
import 'package:fskymusic/provider/user_model.dart';
import 'package:fskymusic/route/navigate_service.dart';
import 'package:fskymusic/route/routes.dart';
import 'package:fskymusic/utils/consts.dart';
import 'package:provider/provider.dart';

void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  Application.setupLocator();
  LogUtil.init(tag: 'NETEASE_MUSIC');
  
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
       ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
      ),
      ChangeNotifierProvider<PlaySongsModel>(
        create: (_) => PlaySongsModel()..init(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: Application.getIt<NavigateService>().key,
      // theme: Constants.darkTheme,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          splashColor: Colors.transparent,
          tooltipTheme: TooltipThemeData(verticalOffset: -100000)),
      home: SplashPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
 
}
