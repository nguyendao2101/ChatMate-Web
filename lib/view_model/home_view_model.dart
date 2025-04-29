import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeViewModel extends GetxController {
  var isDrawerOpen = false.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var userRole = ''.obs; // <--- Biến để lưu role hiện tại

  @override
  void onInit() {
    super.onInit();
    fetchUserRole(); // Gọi luôn khi khởi tạo
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
    isDrawerOpen.value = false;
  }

  void fetchUserRole() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user.uid}/role");
        DatabaseEvent event = await ref.once();
        final role = event.snapshot.value;
        if (role != null) {
          userRole.value = role.toString();
          print("User role: ${userRole.value}");
        } else {
          print("Không tìm thấy role cho user.");
        }
      }
    } catch (e) {
      print("Lỗi lấy role: $e");
    }
  }
}
