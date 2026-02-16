import 'package:client/ui/screens/register/signup.dart';
import 'package:client/ui/screens/splash/register.dart';
import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/material.dart';

import 'ui/screens/register/login.dart';
import 'ui/screens/splash/splash1.dart';
import 'ui/screens/splash/splash2.dart';
import 'ui/screens/splash/splash3.dart';
import 'ui/theme/theme.dart';



// void main() => runApp(
//      DevicePreview(
//       enabled:  true,
//       tools: [
//         ...DevicePreview.defaultTools
//       ],
//       builder: (context) => MyApp()
//     )
// );
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Splash1()
      // home: Register(),
      // home: Signup(),
      // home: Login(),
    );
  }
}

