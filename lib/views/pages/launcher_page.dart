import 'package:blog_admin/utils/share_pref.dart';
import 'package:flutter/material.dart';

import 'home-page/home_page.dart';
import 'login-page/login_page.dart';


class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
      String? token = await SharePref.getToken();
      if(token == null || token.isEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
