import 'package:assignment_2/controller/chatController.dart';
import 'package:assignment_2/controller/userController.dart';
import 'package:assignment_2/screens/chatPage.dart';
import 'package:assignment_2/screens/loginPage.dart';
import 'package:assignment_2/widgets/customButton.dart';
import 'package:assignment_2/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  String dropdownvalue = 'English';
  var items = [
    'English',
    'Sinhala',
  ];
  final userController = Get.find<UserController>();
  TextEditingController updateNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatList();
  }

  void chatList() async {
    userController.readUser();
  }

  void changeLanguage(String lan) {
    if (lan == "English") {
      //Change to english
      var locale = const Locale('en', 'US');
      Get.updateLocale(locale);
    } else {
      //Change to sinhala
      var locale = const Locale('si', 'LK');
      Get.updateLocale(locale);
    }
  }

  void viewChat(index) async {
    String? user1id = userController.userList[index].id.toString();
    String? name = userController.userList[index].name.toString();

    Get.to(() => ChatPage(
          user1id: user1id,
          name: name,
        ));
  }

  void update() async{
    var output =await userController.updateName( updateNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            title: Obx(() => Text(
                "Goog Morning ${userController.userM.value.name}",
                style: const TextStyle(color: Colors.black))),
          ),
          body: TabBarView(children: [
            Center(
              child: ListView.builder(
                itemCount: userController.userList.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.person_rounded, size: 40),
                    title: TextButton(
                      onPressed: () {
                        viewChat(index);
                      },
                      child: Text(
                        "${userController.userList[index].name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing:
                        const Icon(Icons.access_time_filled_outlined, size: 30),
                  );
                },
              ),
            ),

//Setting page here

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Settings".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("User Name".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                        ),
                        MyTextField(
                          controller: updateNameController,
                          hintText: "",
                          obscureText: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Change Language".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Language".tr,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 211, 210, 205),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),

//Language drop down
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  dropdownColor:
                                      const Color.fromARGB(255, 211, 210, 205),
                                  value: dropdownvalue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                      changeLanguage(newValue);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 50),
                        CustomButton(
                            onPressed: () {
                              Get.offAll(const LoginPage());
                            },
                            text: const Text(
                              "Logout",
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
          bottomNavigationBar: Container(
              height: 100,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 219, 217, 217),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: TabBar(
                  labelColor: Colors.purple[800],
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(icon: Icon(Icons.home, size: 50)),
                    Tab(icon: Icon(Icons.settings, size: 50)),
                  ])),
        ),
      ),
    );
  }
}
