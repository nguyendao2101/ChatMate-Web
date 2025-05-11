import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

import '../widgets/common/image_extention.dart';

class GetDataViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  var money = 0.obs; // Giá trị money sẽ được cập nhật ở đây
  var rank = "Normal".obs;
  var timePro = "".obs;

  // Các biến lưu trữ kết quả
  var genderCount = <String, int>{}.obs; // {'Nam': 10, 'Nữ': 5}
  var topQuestions =
      <String, int>{}.obs; // {'alo alo': 12, 'Bún chả Hà Nội': 8}
  var questionAnswers = <String, String>{}.obs; // {'alo alo': 'bot trả lời gì'}
  var topFavouriteMessages =
      <String, int>{}.obs; // {'Nội tiết tố là ...': 20 likes}

  // Các biến Top 10
  var top10Questions = <MapEntry<String, int>>[].obs;
  var top10Favourites = <MapEntry<String, int>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMoney();
    fetchAllData();
  }

  void fetchAllData() async {
    DatabaseReference usersRef = _dbRef.child("users");

    usersRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        genderCount.clear();
        topQuestions.clear();
        questionAnswers.clear();
        topFavouriteMessages.clear();

        (data as Map).forEach((userId, userData) {
          if (userData is Map) {
            // Đếm giới tính
            String sex = userData['sex'] ?? 'Không rõ';
            genderCount[sex] = (genderCount[sex] ?? 0) + 1;

            // Xử lý lịch sử chat
            if (userData['historyChat'] != null &&
                userData['historyChat'] is Map) {
              Map historyChat = userData['historyChat'];

              historyChat.forEach((chatId, chatData) {
                if (chatData is Map) {
                  String userMsg = chatData['userMessage'] ?? '';
                  String botMsg = chatData['botMessage'] ?? '';

                  if (userMsg.isNotEmpty) {
                    topQuestions[userMsg] = (topQuestions[userMsg] ?? 0) + 1;
                    questionAnswers[userMsg] = botMsg;
                  }
                }
              });
            }

            // Xử lý favouriteMessages
            if (userData['favouriteMessages'] != null &&
                userData['favouriteMessages'] is List) {
              List favMessages = userData['favouriteMessages'];
              for (var messageContent in favMessages) {
                if (messageContent is String) {
                  topFavouriteMessages[messageContent] =
                      (topFavouriteMessages[messageContent] ?? 0) + 1;
                }
              }
            }
          }
        });

        // Cập nhật Top 10
        top10Questions.value = _getTop10(topQuestions);
        top10Favourites.value = _getTop10(topFavouriteMessages);

        print("Top 10 câu hỏi: $top10Questions");
        print("Top 10 yêu thích: $top10Favourites");
      } else {
        print('Không tìm thấy dữ liệu người dùng!');
      }
    });
  }

  // Hàm lọc Top 10
  List<MapEntry<String, int>> _getTop10(Map<String, int> map) {
    var sorted = map.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(10).toList();
  }

  void exportToPDF(BuildContext context) async {
    final pdf = pw.Document();

    try {
      // Load font hỗ trợ tiếng Việt
      final fontData = await rootBundle.load('assets/font/Roboto-Regular.ttf');
      final ttf = pw.Font.ttf(fontData);

      // Load ảnh (nếu cần)
      final imageData =
          await rootBundle.load(ImageAssest.logoApp); // Ví dụ logo đầu
      final imageBottomData =
          await rootBundle.load(ImageAssest.logoApp); // Ví dụ logo cuối
      final image = pw.MemoryImage(imageData.buffer.asUint8List());
      final image2 = pw.MemoryImage(imageBottomData.buffer.asUint8List());

      // Chuẩn bị dữ liệu bảng cho Top 10 câu hỏi
      final List<List<String>> questionData = [
        ['Câu hỏi phổ biến', 'Lượt hỏi'], // headers
        ...top10Questions.map((item) => [item.key, item.value.toString()]),
      ];

      // Chuẩn bị dữ liệu bảng cho Top 10 tin nhắn yêu thích
      final List<List<String>> favouriteData = [
        ['Tin nhắn yêu thích'], // headers
        ...top10Favourites.map((item) => [item.key, item.value.toString()]),
      ];

      // Hàm chia dữ liệu thành các phần nhỏ
      List<List<List<String>>> _paginateData(
          List<List<String>> data, int rowsPerPage) {
        List<List<List<String>>> pages = [];
        for (int i = 1; i < data.length; i += rowsPerPage) {
          pages.add(data.sublist(i,
              i + rowsPerPage > data.length ? data.length : i + rowsPerPage));
        }
        return pages;
      }

      // Chia dữ liệu bảng thành các trang (20 dòng mỗi trang)
      final questionPages = _paginateData(questionData, 20);
      final favouritePages = _paginateData(favouriteData, 20);

      // Thêm các trang PDF
      for (var pageIndex = 0; pageIndex < questionPages.length; pageIndex++) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  if (pageIndex == 0)
                    pw.Image(image,
                        height: 100), // Chỉ hiển thị logo ở trang đầu
                  if (pageIndex == 0) pw.SizedBox(height: 20),
                  if (pageIndex == 0)
                    pw.Text(
                      'THỐNG KÊ CHATBOT',
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  if (pageIndex == 0) pw.SizedBox(height: 20),
                  pw.Text(
                    '10 Câu Hỏi Phổ Biến',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table.fromTextArray(
                    headers: questionData[0],
                    data: questionPages[pageIndex],
                    border: pw.TableBorder.all(),
                    headerStyle: pw.TextStyle(
                      font: ttf,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    cellStyle: pw.TextStyle(
                      font: ttf,
                      fontSize: 8,
                    ),
                    cellAlignment: pw.Alignment.centerLeft,
                  ),
                ],
              );
            },
          ),
        );
      }

      for (var pageIndex = 0; pageIndex < favouritePages.length; pageIndex++) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  if (pageIndex == 0)
                    pw.Image(image2,
                        height: 80), // Chỉ hiển thị logo ở trang đầu
                  pw.SizedBox(height: 20),
                  pw.Text(
                    '10 Tin Nhắn Yêu Thích',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Table.fromTextArray(
                    headers: favouriteData[0],
                    data: favouritePages[pageIndex],
                    border: pw.TableBorder.all(),
                    headerStyle: pw.TextStyle(
                      font: ttf,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    cellStyle: pw.TextStyle(
                      font: ttf,
                      fontSize: 8,
                    ),
                    cellAlignment: pw.Alignment.centerLeft,
                  ),
                ],
              );
            },
          ),
        );
      }

      // Save file
      final bytes = await pdf.save();

      if (kIsWeb) {
        final blob = html.Blob([bytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "ThongKeChatbot2024.pdf")
          ..click();
        html.Url.revokeObjectUrl(url);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ File PDF đã được tải xuống!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('❌ Nền tảng không hỗ trợ xuất file PDF')),
        );
      }
    } catch (e) {
      print('Lỗi xuất PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Không thể xuất PDF: $e')),
      );
    }
  }

  void fetchMoney() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      print(
          'User ID hiện tại: $userId'); // Kiểm tra xem userId có được lấy đúng không

      DatabaseReference moneyRef = _dbRef.child("users/$userId/money");

      moneyRef.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null) {
          money.value = data as int; // Cập nhật giá trị money
          print('Số tiền hiện tại: $money'); // Kiểm tra giá trị money
        } else {
          print('Không tìm thấy dữ liệu số tiền cho user $userId');
        }
      });
    } else {
      print('Không tìm thấy người dùng nào đang đăng nhập.');
    }
  }

  void updateMoney(int addedMoney) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference moneyRef = _dbRef.child("users/$userId/money");

      moneyRef.once().then((DatabaseEvent event) {
        final data = event.snapshot.value;
        int currentMoney = (data != null) ? data as int : 0;
        int updatedMoney = currentMoney + addedMoney;
        moneyRef.set(updatedMoney);
        money.value = updatedMoney; // Cập nhật giá trị money trong app
      });
    }
  }

  void updateByMoney(int addedMoney) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference moneyRef = _dbRef.child("users/$userId/money");

      moneyRef.once().then((DatabaseEvent event) {
        final data = event.snapshot.value;
        int currentMoney = (data != null) ? data as int : 0;
        int updatedMoney = currentMoney - addedMoney;
        moneyRef.set(updatedMoney);
        money.value = updatedMoney; // Cập nhật giá trị money trong app
      });
    }
  }

  void updateRank(String duration) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef = _dbRef.child("users/$userId");

      DateTime now = DateTime.now();
      DateTime expiryDate;

      switch (duration) {
        case "1 Tuần":
          expiryDate = now.add(Duration(days: 7));
          break;
        case "1 Tháng":
          expiryDate = now.add(Duration(days: 30));
          break;
        case "1 Quý":
          expiryDate = now.add(Duration(days: 90));
          break;
        case "1 Năm":
          expiryDate = now.add(Duration(days: 365));
          break;
        default:
          print("Thời gian không hợp lệ");
          return;
      }

      String formattedExpiryDate = DateFormat('yyyy-MM-dd').format(expiryDate);

      userRef
          .update({"ranking": "Pro", "timePro": formattedExpiryDate}).then((_) {
        rank.value = "Pro";
        timePro.value = formattedExpiryDate;
        print("Cập nhật rank thành công: Pro đến $formattedExpiryDate");
      }).catchError((error) {
        print("Lỗi khi cập nhật rank: $error");
      });
    }
  }

  Future<bool> canAskQuestion() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef = _dbRef.child("users/$userId");
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          int questionCount = data["dailyQuestions"] ?? 0;
          String lastDate = data["lastAskedDate"] ?? "";
          String userRank = data["rank"] ?? "Normal";

          if (userRank == "Pro") return true;

          if (lastDate != today) {
            userRef.update({"dailyQuestions": 1, "lastAskedDate": today});
            return true;
          } else {
            if (questionCount < 50) {
              userRef.update({"dailyQuestions": questionCount + 1});
              return true;
            } else {
              return false;
            }
          }
        }
      }
    }
    return false;
  }
}
