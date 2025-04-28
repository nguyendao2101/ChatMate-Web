import 'package:flutter/material.dart';
import 'package:flutter_chatmate_web/view/chat_view.dart';
import 'package:flutter_chatmate_web/view_model/home_view_model.dart';
import 'package:flutter_chatmate_web/widgets/common/color_extention.dart';
import 'package:flutter_chatmate_web/widgets/common/image_extention.dart';
import 'package:get/get.dart';

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

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: ChatColor.background,
      drawer: Drawer(
        backgroundColor: ChatColor.background,
        child: ListView(
          padding: EdgeInsets.zero,
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
                      'History Chat',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ChatColor.almond,
                      ),
                    )
                  ],
                ),
              ),
            )
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
                onSelected: (selectIndex) {},
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      height: 30,
                      child: Text(
                        "Log Out",
                        style:
                            TextStyle(fontSize: 12, color: ChatColor.lightGray),
                      ),
                    ),
                  ];
                }),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          const Expanded(flex: 1, child: ChatScreen()),
          const Expanded(flex: 1, child: DataExportPdf()),
        ],
      ),
    );
  }
}
