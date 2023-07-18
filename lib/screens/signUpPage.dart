import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/userController.dart';
import '../widgets/customButton.dart';
import '../widgets/myTextField.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var userController = Get.find<UserController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool isLoading = false;
  bool checkBox = false;

  void check(bool? value) {
    setState(() {
      checkBox = value ?? false;
    });
  }

  void signUp() {
    if (checkBox) {
      userController.insertUser(
        email: emailController.text,
        password: passwordController.text,
        name: userNameController.text,
      );
    } else {
      Get.snackbar("Please agree with Terms of Service", "");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "Create an account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 65),

                    //Email Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MyTextField(
                          controller: emailController,
                          hintText: "email@gmail.com",
                          obscureText: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //Password Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MyTextField(
                          controller: passwordController,
                          hintText: "",
                          obscureText: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //User Name Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "User Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MyTextField(
                          controller: userNameController,
                          hintText: "",
                          obscureText: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //Check Box
                    Row(
                      children: [
                        Checkbox(
                          value: checkBox,
                          onChanged: check,
                        ),
                        RichText(
                          text: const TextSpan(
                            text: "By signing up, I understand and agree to ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\nTerms of Service',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    //Button
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              signUp();
                            },
                            text: const Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),

                    const SizedBox(height: 130),

                    TextButton(
                      onPressed: () {
                        Get.to(() => const LoginPage());
                      },
                      child: Text(
                        "I already have an account",
                        style: TextStyle(
                          color: Colors.purple[800],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
