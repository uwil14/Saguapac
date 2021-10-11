// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saguapac/provider/data_provider.dart';
import 'package:saguapac/widgets/home_page.dart';
import 'package:saguapac/widgets/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DataProvider()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            scrollBehavior:
            const ScrollBehavior().copyWith(physics: const BouncingScrollPhysics()),
            theme: ThemeData(
              fontFamily: 'MontserratRegular',
            ),
            debugShowCheckedModeBanner: false,
            home:  SplashScreen(),
          );
        }));
  }
}
