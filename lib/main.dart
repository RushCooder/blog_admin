import 'package:blog_admin/providers/auth_provider.dart';
import 'package:blog_admin/providers/blog_provider.dart';
import 'package:blog_admin/views/blog_admin_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BlogProvider(),
        ),
      ],
      child: const BlogAdminApp(),
    ),
  );
}
