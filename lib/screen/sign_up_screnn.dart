import 'package:flutter/material.dart';
import 'package:todolist_app/components/my_button.dart';
import 'package:todolist_app/components/my_textfield.dart';
import 'package:todolist_app/constant/constant.dart';
import 'package:todolist_app/screen/sign_in_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final re_passswordController = TextEditingController();
  final String txtMsg = '';

void _showDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Colors.pink,
            title: const Text('Sign In'),
            content: Text(txtMsg),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('OK')),
            ],
          ),
          );
      },
    );
  }

void signUp () async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text,
  );
  _showDialog("Account Created, ");
  
  } on FirebaseAuthException catch (e) {
  _showDialog("Failed to create Account!");
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(15, 80, 15, 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to KMUTNB community', style: textTitle,),
              const SizedBox(height: 20,),
              Text('To get started, please provide the information to create an account', style: textSubTitle,),
              const SizedBox(height: 30,),
              MyTextField(controller: nameController, hintText: 'Enter your name', obscureText: false, labelText: 'Name'),
              const SizedBox(height: 30,),
              MyTextField(controller: emailController, hintText: 'Enter your email', obscureText: false, labelText: 'Email'),
              const SizedBox(height: 30,),
              MyTextField(controller: passwordController, hintText: 'Enter your password', obscureText: true, labelText: 'Password'),
              const SizedBox(height: 30,),
              MyTextField(controller: re_passswordController, hintText: 'Enter your password again', obscureText: true, labelText: 'Re- Password'),
              const SizedBox(height: 30,),
              MyButton(onTap: signUp, hinText: 'Register now'),
          
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have a member?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
            ],
            ),
        ),
      ),
    );
  }
}