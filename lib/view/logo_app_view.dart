import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatmate_web/view_model/logo_app_view_model.dart';
import 'package:flutter_chatmate_web/widgets/common/color_extention.dart';
import 'package:flutter_chatmate_web/widgets/common/image_extention.dart';
import 'package:get/get.dart';

class LogoAppView extends StatefulWidget {
  const LogoAppView({super.key});

  @override
  State<LogoAppView> createState() => _LogoAppViewState();
}

class _LogoAppViewState extends State<LogoAppView> {
  late Timer _timer;
  late int _seconds;
  final controller = Get.put(LogoAppViewModel());

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    _seconds = DateTime.now().second; // Lấy số giây hiện tại
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds = DateTime.now().second; // Cập nhật số giây
      });
    });
    controller.loadView();
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy Timer khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColor.background,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              ImageAssest.logoApp,
              height: 232,
              width: 232,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'ChatMate',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  height: 4.125,
                  color: ChatColor.almond),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  (_seconds % 2 == 0)
                      ? ImageAssest.loading2
                      : ImageAssest.loading1,
                  height: 96,
                  width: 96,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Đang tải...',
                  style: TextStyle(
                      color: ChatColor.almond,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      height: 1.375),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
