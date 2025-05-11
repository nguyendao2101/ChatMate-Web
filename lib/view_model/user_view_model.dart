import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final _userData = {}.obs;
  String _userId = '';
  RxMap get userData => _userData;

  @override
  void onInit() {
    super.onInit();
    initializeUserId();
  }

  void initializeUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      await _getUserData();
    }
  }

  Future<void> _getUserData() async {
    try {
      DatabaseReference userRef = _database.child('users/$_userId');
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        _userData.value = Map<String, dynamic>.from(snapshot.value as Map);
        print("Dữ liệu người dùng: ${_userData.value}");
      } else {
        _userData.value = {};
        print("Không tìm thấy dữ liệu người dùng!");
      }
    } catch (e) {
      print("Lỗi khi tải dữ liệu người dùng: $e");
      _userData.value = {};
    }
  }
}
