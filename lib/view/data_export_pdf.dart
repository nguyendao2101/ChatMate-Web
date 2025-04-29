import 'package:flutter/material.dart';
import 'package:flutter_chatmate_web/view_model/get_data_view_model.dart';
import 'package:get/get.dart';
import '../widgets/common/color_extention.dart';

class DataExportPdf extends StatefulWidget {
  const DataExportPdf({super.key});

  @override
  State<DataExportPdf> createState() => _DataExportPdfState();
}

class _DataExportPdfState extends State<DataExportPdf> {
  final controller = Get.put(GetDataViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColor.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              controller.exportToPDF(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ChatColor.almond,
            ),
            child: const Text(
              'Xuất PDF',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
