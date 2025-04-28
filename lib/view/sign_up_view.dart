import 'package:flutter/material.dart';
import 'package:flutter_chatmate_web/view/login_view.dart';
import 'package:flutter_chatmate_web/view_model/sign_up_view_model.dart';
import 'package:flutter_chatmate_web/widgets/common/color_extention.dart';
import 'package:flutter_chatmate_web/widgets/common/image_extention.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpViewModel());
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssest.loginBackground,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
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
                        'Create Account', // Thay đổi thành nội dung bạn muốn hiển thị
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
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              'SIGN UP',
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
                            const SizedBox(height: 16),
                            _formEntryPassword(controller),
                            const SizedBox(height: 16),
                            _formName(controller),
                            const SizedBox(height: 16),
                            _formAddress(controller),
                            const SizedBox(height: 16),
                            _formSex(controller),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.isValidSignupForm()) {
                                    controller.isLoading.value = true;
                                    controller.signUp(
                                      controller.email ?? '',
                                      controller.password ?? '',
                                      controller.confirmPassword ?? '',
                                      controller.hoTen ?? '',
                                      controller.address ?? '',
                                      controller.sex ?? '',
                                      () {
                                        controller.isLoading.value = false;
                                        Get.snackbar(
                                          'Success',
                                          'Đăng ký thành công',
                                          snackPosition: SnackPosition.TOP,
                                        );

                                        // Reset form state if needed
                                        controller.resetForm();

                                        // Navigate to Login Screen
                                        Get.offAll(() => const LoginView());
                                      },
                                      (error) {
                                        controller.isLoading.value = false;
                                        Get.snackbar(
                                          'Error',
                                          error,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ChatColor.almond,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Thiết lập viền bo tròn
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15), // Tăng chiều cao của nút
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Căn giữa chữ "Sign Up"
                                  children: [
                                    Text(
                                      'Sign Up',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ))
            ],
          )
        ],
      ),
    ));
  }

  Padding _formEmail(SignUpViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
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

  Padding _formPassword(SignUpViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Obx(
        () => TextFormField(
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

  Padding _formEntryPassword(SignUpViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Obx(
        () => TextFormField(
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
          onChanged: controller.onChangeConfirmPassword,
          validator: controller.validatorConfirmPassword,
        ),
      ),
    );
  }

  Padding _formName(SignUpViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: false,
        style: const TextStyle(
            color: Colors.white), // Text color to white for better visibility
        decoration: InputDecoration(
          labelText: 'Full Name',
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
          hintText: 'Full Name',
          hintStyle: TextStyle(
              color: Colors.white
                  .withOpacity(0.6)), // Slightly transparent hint text
        ),
        onChanged: controller.onChangeCheckName,
        validator: controller.validatorCheck,
      ),
    );
  }

  Padding _formAddress(SignUpViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: false,
        style: const TextStyle(
            color: Colors.white), // Text color to white for better visibility
        decoration: InputDecoration(
          labelText: 'Address',
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
          hintText: 'Address',
          hintStyle: TextStyle(
              color: Colors.white
                  .withOpacity(0.6)), // Slightly transparent hint text
        ),
        onChanged: controller.onChangeCheckAdress,
        validator: controller.validatorCheck,
      ),
    );
  }

  Padding _formSex(SignUpViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: false,
        style: const TextStyle(
            color: Colors.white), // Text color to white for better visibility
        decoration: InputDecoration(
          labelText: 'Sex',
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
          hintText: 'Sex',
          hintStyle: TextStyle(
              color: Colors.white
                  .withOpacity(0.6)), // Slightly transparent hint text
        ),
        onChanged: controller.onChangeCheckSex,
        validator: controller.validatorCheck,
      ),
    );
  }
}
