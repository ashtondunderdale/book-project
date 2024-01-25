import 'package:elysium/models/elysium_user.dart';
import 'package:elysium/views/notes.dart';
import 'package:elysium/views/register.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/styles.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 96),
              child: Text(
                "Elysium",
                style: Styles.elysiumTitleStyle,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 128),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Login",
                          style: Styles.loginHintStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          cursorColor: Styles.mediumGrey,
                          controller: emailController,
                          validator: _validateEmail,
                          decoration: Styles.loginDecoration.copyWith(
                            hintText: "email",
                            hintStyle: Styles.loginHintStyle,
                          ),
                          style: Styles.loginHintStyle,
                        ),
                      ),
                      TextFormField(
                        cursorColor: Styles.mediumGrey,
                        controller: passwordController,
                        obscureText: true,
                        validator: _validatePassword,
                        decoration: Styles.loginDecoration.copyWith(
                          hintText: "password",
                          hintStyle: Styles.loginHintStyle,
                        ),
                        style: Styles.loginHintStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 64),
                        child: IconButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {

                              if (await AuthService.tryLogin(emailController.text, passwordController.text)) {
                                ElysiumUser elysiumUser = ElysiumUser();
                                
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => Notes(
                                      elysiumUser: elysiumUser
                                    )
                                  ),
                                );
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Styles.lightGrey,
                            size: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 128),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Text(
                            "Or Register here",
                            style: Styles.loginHintStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
