import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatmate_web/view/chat_view.dart';
import 'package:flutter_chatmate_web/view/login_view.dart';
import 'package:flutter_chatmate_web/view/user_view.dart';
import 'package:flutter_chatmate_web/view_model/home_view_model.dart';
import 'package:flutter_chatmate_web/widgets/common/color_extention.dart';
import 'package:flutter_chatmate_web/widgets/common/image_extention.dart';
import 'package:get/get.dart';

import '../view_model/get_data_view_model.dart';
import 'data_export_pdf.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeViewModel());
    var media = MediaQuery.sizeOf(context);
    final controllerGetData = Get.put(GetDataViewModel());

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: ChatColor.background,
      drawer: Drawer(
        backgroundColor: ChatColor.background,
        child: Column(
          children: [
            SizedBox(
              height: 230,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: ChatColor.gray6.withOpacity(0.03)),
                child: Column(
                  children: [
                    Image.asset(
                      ImageAssest.logoApp,
                      width: media.width * 0.1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lịch Sử Trò Chuyện',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ChatColor.almond,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<DataSnapshot>(
                future: FirebaseDatabase.instance
                    .ref(
                        'users/${FirebaseAuth.instance.currentUser?.uid}/historyChat')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Lỗi khi tải dữ liệu!',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.value == null) {
                    return Center(
                      child: Text(
                        'Không có lịch sử trò chuyện.',
                        style: TextStyle(color: ChatColor.gray4),
                      ),
                    );
                  }

                  final historyChat =
                      snapshot.data!.value as Map<dynamic, dynamic>;
                  return ListView.builder(
                    itemCount: historyChat.length,
                    itemBuilder: (context, index) {
                      final key = historyChat.keys.elementAt(index);
                      final chatEntry = historyChat[key];
                      return ListTile(
                        title: Text(
                          chatEntry['userMessage'] ?? 'Tin nhắn không xác định',
                          style: TextStyle(color: ChatColor.gray4),
                        ),
                        subtitle: Text(
                          chatEntry['date'] ?? '',
                          style: TextStyle(color: ChatColor.lightGray),
                        ),
                        onTap: () {
                          // Xử lý khi nhấn vào một mục lịch sử
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: ChatColor.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            controller.openDrawer();
          },
          icon: Image.asset(
            ImageAssest.drawerHome,
            height: 50,
            width: 50,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: PopupMenuButton<int>(
              color: ChatColor.gray1,
              offset: const Offset(-10, 15),
              elevation: 1,
              icon: Image.asset(
                ImageAssest.users,
                width: 64,
                height: 64,
              ),
              padding: EdgeInsets.zero,
              onSelected: (selectedIndex) {
                if (selectedIndex == 1) {
                  Get.offAll(const LoginView());
                } else if (selectedIndex == 2) {
                  controllerGetData.exportToPDF(context);
                } else {
                  Get.to(() => const UserView());
                }
              },
              itemBuilder: (context) {
                return [
                  if (controller.userRole.value.toString() == 'admin')
                    PopupMenuItem(
                      value: 2,
                      height: 30,
                      child: Text(
                        "Xuất PDF",
                        style:
                            TextStyle(fontSize: 12, color: ChatColor.lightGray),
                      ),
                    ),
                  PopupMenuItem(
                    value: 3,
                    height: 30,
                    child: Text(
                      "Thông tin tài khoản",
                      style:
                      TextStyle(fontSize: 12, color: ChatColor.lightGray),
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    height: 30,
                    child: Text(
                      "Đăng Xuất",
                      style:
                      TextStyle(fontSize: 12, color: ChatColor.lightGray),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          const Expanded(flex: 1, child: ChatScreen()),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
