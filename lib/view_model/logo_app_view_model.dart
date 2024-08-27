import 'package:flutter_chatmate_web/view/login_view.dart';
import 'package:get/get.dart';

class LogoAppViewModel extends GetxController {
  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(() => const LoginView());
  }
}
