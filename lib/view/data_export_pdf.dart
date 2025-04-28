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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // if (controller.formKey.currentState
            //     ?.validate() ==
            //     true) {
            //   controller.onlogin();
            // }
            controller.exportToPDF(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ChatColor.almond,
          ),
          child: const Text(
            'Export PDF',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
