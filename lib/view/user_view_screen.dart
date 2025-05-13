import 'package:flutter/material.dart';
import 'package:flutter_chatmate_web/view/user_view.dart';
import '../widgets/common/color_extention.dart';

class UserViewScreen extends StatefulWidget {
  const UserViewScreen({super.key});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<UserViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColor.background,
      body: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          const Expanded(flex: 1, child: UserView()),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
