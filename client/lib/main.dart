import 'package:client/services/auth_service.dart';
import 'package:client/ui/screens/home/home.dart';
import 'package:client/ui/screens/inspect_post/comment_view.dart';
import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/screens/profile/following.dart';
import 'package:client/ui/screens/register/signup.dart';
import 'package:client/ui/screens/splash/register.dart';
import 'package:client/ui/widgets/displays/comment.dart';
import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/material.dart';

import 'ui/screens/profile/edit_profile.dart';
import 'ui/screens/profile/profile.dart';
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authService.init();
  final loggedIn = await authService.isLoggedIn();
  runApp(MyApp(isLoggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: isLoggedIn ? AppRoot() : Splash1(),
      // home: Register(),
      // home: Signup(),
      // home: Login(),
      // home: Home(),
      // home: EditProfile()
      // home: Profile()
      // home: Following(),
      // home: InspectPost(),
      // home: CommentView(),
      // home: AppRoot(),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          Home(),
          Profile()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20), 
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20), 
            border: Border.all(color: const Color.fromARGB(255, 239, 238, 238), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4), 
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), 
            child: BottomNavigationBar(
              elevation: 10,
              type: BottomNavigationBarType.fixed, 
              selectedItemColor: Color(0xFF438883),
              unselectedItemColor: Colors.grey,
              currentIndex: _currentTabIndex,
              onTap: (index) {
                setState(() => _currentTabIndex = index);
              },
              items: [
                BottomNavigationBarItem(icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.house_rounded),
                ), label: "Home"),
                // BottomNavigationBarItem(icon: Padding(
                //   padding: EdgeInsets.symmetric(vertical: 8),
                //   child: Icon(Icons.bar_chart_rounded),
                // ), label: "Notification"),
                // BottomNavigationBarItem(icon: Padding(
                //   padding: EdgeInsets.symmetric(vertical: 8),
                //   child: Icon(Icons.track_changes),
                // ), label: "Create"),
                BottomNavigationBarItem(icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.person),
                ), label: "Profile"),
              ],
            ),
          )
        )
      )
    );
  }
}

