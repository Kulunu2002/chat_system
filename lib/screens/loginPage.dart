import 'package:assignment_2/screens/signUpPage.dart';
import 'package:assignment_2/widgets/customButton.dart';
import 'package:assignment_2/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/databaseSetup.dart';

import '../controller/userController.dart';
import 'dashBoardPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setupDB();
  }

  void setupDB() async {
    DatabaseSetup databaseSetup = DatabaseSetup();
    await databaseSetup.setUpDB();
    databaseSetup.createUserTable();
    // databaseSetup.createChatTable();
  }

  void login() async {
    var output = await UserController().readUserEandP(
        email: emailController.text, password: passwordController.text);

    if (output) {
  
      Get.to(() => const DashBoardPage());
    } else {
      Get.snackbar("Error! User document not found", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text("Welcome back",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                    const SizedBox(height: 65),

                    //Email Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        MyTextField(
                          controller: emailController,
                          hintText: "email@gmail.com",
                          obscureText: false,
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    //Password Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        MyTextField(
                          controller: passwordController,
                          hintText: "",
                          obscureText: true,
                        )
                      ],
                    )
                  ]),

              const SizedBox(height: 80),

              //Button
              CustomButton(
                onPressed: () {
                  login();
                },
                text: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 250),

              TextButton(
                  onPressed: () {
                    Get.to(() => const SignUpPage());
                  },
                  child: Text(
                    "I don't have an account",
                    style: TextStyle(
                        color: Colors.purple[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
