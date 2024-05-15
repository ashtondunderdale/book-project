import 'package:barden_book_project/authentication/services/auth.dart';
import 'package:barden_book_project/constants.dart';
import 'package:barden_book_project/authentication/widgets/barden_button.dart';
import 'package:barden_book_project/authentication/widgets/barden_header.dart';
import 'package:barden_book_project/authentication/widgets/barden_textfield.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  BardenAuth _auth = BardenAuth();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String authMessage = "";

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLeftLoginBox(context),
          _buildRightLoginBox(context),
        ],
      ),
    ),
  );
Widget _buildLeftLoginBox(BuildContext context) => Container(
  width: 600,
  height: MediaQuery.sizeOf(context).height * 0.7,
  decoration: BoxDecoration(
    color: bardenPurple,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(4), 
      bottomLeft: Radius.circular(4)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 7,
        offset: const Offset(-3, 0),
      ),
    ],
  ),
  child: Stack(
    children: [
      Positioned.fill(
        child: Opacity(
          opacity: 0.15,
          child: Image.asset(
            '../assets/barden_primary_reading_graphic.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: Image.asset(
          '../assets/barden_primary_logo.png', 
          fit: BoxFit.fitHeight,
          height: 140,
        ),
      ),
    ],
  ),
);


  Widget _buildRightLoginBox(BuildContext context) => Container(
    width: 400,
    height: MediaQuery.sizeOf(context).height * 0.7,
    decoration: BoxDecoration(    
      color: Colors.white,
      borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(3, 0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 20),
        const BardenHeader(),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: 136),
          child: Text(
            "STAFF LOGIN",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        ),
        BardenTextfield(text: "username", isPassword: false, controller: usernameController),
        const SizedBox(height: 20),
        BardenTextfield(text: "password", controller: passwordController),
        const SizedBox(height: 60),
        Text(
          authMessage,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12
          ),
        ),
        BardenButton(
          text: "LOGIN", 
          onPressed: () {
            var authSuccess = _auth.loginWithUsernameAndPassword(usernameController.text, passwordController.text);
            authSuccess = false;

            if (!authSuccess) {
              setState(() {
                authMessage = "Incorrect login details"; // distinguish between incorrect login and unexpected error
              });
            }
          }
        ),
        const SizedBox(height: 20)
      ],
    ),
  );
}