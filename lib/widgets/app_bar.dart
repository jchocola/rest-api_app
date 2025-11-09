import 'package:api_client/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title, this.actions = const [] ,this.leading});
  final String title;
  final List<Widget> actions;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
       title: Text(title),
       leading: leading,
     actions: actions, 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppConstant.appbarHeight);
}
