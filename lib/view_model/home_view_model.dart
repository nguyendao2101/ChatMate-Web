import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetBuilderState {
  var isDrawerOpen = false.obs; // Khởi tạo biến quan sát
  var scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
    isDrawerOpen.value = false;
  }
}
