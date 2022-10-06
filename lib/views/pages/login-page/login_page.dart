import 'package:blog_admin/providers/auth_provider.dart';
import 'package:blog_admin/providers/blog_provider.dart';
import 'package:blog_admin/utils/toast.dart';
import 'package:blog_admin/views/pages/launcher_page.dart';
import 'package:blog_admin/views/widgets/custom_form_field.dart';
import 'package:blog_admin/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login';
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 35, top: 80),
          child: const Text(
            "Welcome\nBack",
            style: TextStyle(color: Colors.black, fontSize: 33),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: 35,
                left: 35,
                top: MediaQuery.of(context).size.height * 0.3),
            child: Column(children: [
              CustomFormField(
                controller: emailController,
                icon: Icons.email,
                labelText: 'Email',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomFormField(
                controller: passwordController,
                icon: Icons.lock,
                labelText: 'Password',
                isPassword: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xff4c505b),
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xff4c505b),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        showLoadingDialog(context);
                        context
                            .read<AuthProvider>()
                            .login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            )
                            .then(
                          (value) {
                            Navigator.pop(context);
                            if (value) {
                              Navigator.pushReplacementNamed(
                                  context, LauncherPage.routeName);
                            } else {
                              showToast(context, 'Login Failed');
                            }
                          },
                        ).onError(
                          (error, stackTrace) {
                            Navigator.pop(context);
                            showToast(context, 'Login Failed');
                          },
                        );
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
