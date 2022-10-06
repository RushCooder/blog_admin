import 'package:blog_admin/views/pages/add-blog-page/add_blog_page.dart';
import 'package:blog_admin/views/pages/home-page/home_page.dart';
import 'package:blog_admin/views/pages/launcher_page.dart';
import 'package:blog_admin/views/pages/login-page/login_page.dart';
import 'package:flutter/material.dart';

class BlogAdminApp extends StatelessWidget {
  const BlogAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Admin',
      initialRoute: LauncherPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) =>  LoginPage(),
        AddBlogPage.routeName: (context) => AddBlogPage(),
      },
    );
  }
}
