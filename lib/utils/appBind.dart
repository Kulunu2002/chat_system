import 'package:assignment_2/controller/chatController.dart';
import 'package:get/get.dart';
import '../controller/userController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(ChatController());
  }
}
