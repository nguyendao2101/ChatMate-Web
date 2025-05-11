// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/user_view_model.dart';
import '../widgets/common/color_extention.dart';
import '../widgets/common/image_extention.dart';
import '../widgets/common_widget/user/favourite_message.dart';
import 'login_view.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<UserView> {
  final controller = Get.put(UserViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initializeUserId();
    ever(controller.userData, (_) {
      print("Dữ liệu người dùng: ${controller.userData}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColor.background,
      appBar: AppBar(
        backgroundColor: ChatColor.background,
        elevation: 0,
        title: Text(
          'Thông tin người dùng',
          style: TextStyle(
            color: ChatColor.almond,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileImage(),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.userData.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else {
                  return _buildUserInfoCard();
                }
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() => LoginView());
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: ChatColor.almond),
                child: const Text(
                  'Đăng Xuất',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'PlusJakartaSans'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width:
          110, // Kích thước tổng thể của hình đại diện (bằng với radius*2 + borderWidth)
      height: 110,
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   border: Border.all(
      //     color: ChatColor.almond, // Màu của viền ngoài
      //     width: 4.0, // Độ dày của viền ngoài
      //   ),
      // ),
      child: CircleAvatar(
        radius: 50, // Kích thước của hình đại diện
        backgroundImage: AssetImage(ImageAssest.user),
        backgroundColor: ChatColor.background,
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return controller.userData.isNotEmpty
        ? Card(
            color: ChatColor.gray1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfoRow('Tên', controller.userData['fullName']),
                  const Divider(color: Colors.white24),
                  _buildUserInfoRow(
                      'Email', "  ${controller.userData['email']}"),
                  const Divider(color: Colors.white24),
                  _buildUserInfoRow('Địa chỉ', controller.userData['address']),
                  const Divider(color: Colors.white24),
                  _buildUserInfoRow('Giới tính', controller.userData['sex']),
                  const Divider(color: Colors.white24),
                  _buildUserInfoRow(
                      'Hạng', controller.userData['ranking'].toString()),
                  const Divider(color: Colors.white24),
                  _buildUserInfoRow(
                      'Ví', '${controller.userData['money'].toString()} coins'),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
  }

  Widget _buildUserInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ChatColor.almond,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          Flexible(
            child: Text(
              value ?? '',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'PlusJakartaSans',
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
