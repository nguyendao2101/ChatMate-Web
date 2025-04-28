import 'package:flutter/material.dart';
import 'package:flutter_chatmate_web/view/sign_up_view.dart';
import 'package:flutter_chatmate_web/view_model/login_view_model.dart';
import 'package:flutter_chatmate_web/widgets/common/image_extention.dart';
import 'package:get/get.dart';

import '../widgets/common/color_extention.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewModel());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Hình nền loginBackground
            Positioned.fill(
              child: Image.asset(
                ImageAssest.loginBackground,
                fit: BoxFit.cover,
              ),
            ),
            // Chứa phần form chiếm 1/4 màn hình bên phải
            Row(
              children: [
                // Phần trống chiếm 3/4 màn hình bên trái
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(
                        32.0), // Thêm padding để tạo khoảng cách từ cạnh ngoài
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Căn trái cho các phần tử trong cột
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Đặt logo ở trên và chữ ở dưới cùng
                      children: [
                        // Logo ở góc trên cùng bên trái
                        Image.asset(
                          ImageAssest.logoApp, // Đường dẫn đến logo của bạn
                          height:
                              100, // Bạn có thể điều chỉnh kích thước này theo nhu cầu
                        ),
                        // Chữ ở góc dưới cùng bên trái
                        Text(
                          'Hi welcom back', // Thay đổi thành nội dung bạn muốn hiển thị
                          style: TextStyle(
                              color: ChatColor
                                  .almond, // Màu chữ, bạn có thể thay đổi theo nhu cầu
                              fontSize: 64, // Kích thước chữ
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Phần chứa form chiếm 1/4 màn hình bên phải
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Form(
                      key: controller.formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 78,
                                fontWeight: FontWeight.bold,
                                color: ChatColor.almond,
                              ),
                            ),
                            const SizedBox(height: 32),
                            _formEmail(controller),
                            const SizedBox(height: 16),
                            _formPassword(controller),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: ChatColor.almond2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (controller.formKey.currentState
                                            ?.validate() ==
                                        true) {
                                      controller.onlogin();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ChatColor.almond,
                                  ),
                                  child: const Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                // const SizedBox(width: 16),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     Get.to(() => const SignUpView());
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: ChatColor.almond,
                                //   ),
                                //   child: const Text(
                                //     'Sign Up',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(color: Colors.black),
                                //   ),
                                // ),
                              ],
                            ),
                            // const SizedBox(height: 64),
                            // _textOrContinueWith(),
                            // const SizedBox(height: 32),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Image.asset(
                            //       ImageAssest.logoGG,
                            //       height: 72,
                            //     ),
                            //     const SizedBox(width: 20),
                            //     Image.asset(
                            //       ImageAssest.logoFB,
                            //       height: 58,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     ElevatedButton(
                            //       onPressed: () {
                            //         // Get.to(() => SignUpScreen());
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: const Color(0xFF3B2063),
                            //       ),
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(
                            //             top: 10,
                            //             bottom: 10,
                            //             left: 30,
                            //             right: 30),
                            //         child: Row(
                            //           children: [
                            //             Image.asset(
                            //               ImageAssest.logoGG,
                            //               height: 24,
                            //               width: 24,
                            //             ),
                            //             const SizedBox(
                            //               width: 4,
                            //             ),
                            //             Text(
                            //               'Google',
                            //               textAlign: TextAlign.center,
                            //               style: TextStyle(
                            //                   color: ChatColor.gray7,
                            //                   fontSize: 15.04,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 20,
                            //     ),
                            //     ElevatedButton(
                            //       onPressed: () {},
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: const Color(0xFF3B2063),
                            //       ),
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(
                            //             top: 10,
                            //             bottom: 10,
                            //             left: 30,
                            //             right: 30),
                            //         child: Row(
                            //           children: [
                            //             Image.asset(
                            //               ImageAssest.logoFB,
                            //               height: 20,
                            //               width: 20,
                            //             ),
                            //             const SizedBox(
                            //               width: 5,
                            //             ),
                            //             Text(
                            //               'Facebook',
                            //               textAlign: TextAlign.center,
                            //               style:
                            //                   TextStyle(color: ChatColor.gray7),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _textOrContinueWith() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Or continue with',
              style: TextStyle(color: Color(0xFF616161)),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Padding _formPassword(LoginViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Obx(
        () => TextFormField(
          controller: controller.passwordController,
          obscureText: controller.isObscured.value,
          style: const TextStyle(
              color: Colors.white), // Text color to white for better visibility
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
                color: Colors.white
                    .withOpacity(0.8)), // Slightly transparent label
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded border
              borderSide: BorderSide(
                  color: Colors.grey.shade400, width: 2), // Grey border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  12), // Matching rounded border when focused
              borderSide: const BorderSide(
                  color: Colors.white, width: 2), // White border when focused
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Colors.red, width: 2), // Red border when error
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 2), // Red accent border when focused and error
            ),
            // filled: true,
            // fillColor: Color.fromARGB(255, 50, 50, 50)
            //     .withOpacity(0.8), // Slightly transparent dark background
            hintText: 'Password',
            hintStyle: TextStyle(
                color: Colors.white
                    .withOpacity(0.6)), // Slightly transparent hint text
            suffixIcon: GestureDetector(
              onTap: () => controller.toggleObscureText(),
              child: Icon(
                controller.isObscured.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.white
                    .withOpacity(0.8), // Icon color to match text and label
              ),
            ),
          ),
          onChanged: controller.onChangePassword,
          validator: controller.validatorPassword,
        ),
      ),
    );
  }

  Padding _formEmail(LoginViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller.emailController,
        obscureText: false,
        style: const TextStyle(
            color: Colors.white), // Text color to white for better visibility
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
              color:
                  Colors.white.withOpacity(0.8)), // Slightly transparent label
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Rounded border
            borderSide: const BorderSide(
                color: Color(0xFF77E4C8), width: 2), // Bright turquoise border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                12), // Matching rounded border when focused
            borderSide: const BorderSide(
                color: Colors.white, width: 2), // White border when focused
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: Colors.red, width: 2), // Red border when error
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 2), // Red accent border when focused and error
          ),
          // filled: true,
          // fillColor: Color.fromARGB(255, 50, 50, 50)
          //     .withOpacity(0.8), // Slightly transparent dark background
          hintText: 'Email',
          hintStyle: TextStyle(
              color: Colors.white
                  .withOpacity(0.6)), // Slightly transparent hint text
        ),
        onChanged: controller.onChangeUsername,
        validator: controller.validatorUsername,
      ),
    );
  }
}
