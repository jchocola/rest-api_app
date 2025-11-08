import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/presentation/drawer_page/drawer_page.dart';
import 'package:api_client/presentation/history_page/history_page.dart';
import 'package:api_client/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _onMenuPressed() {
      showShadSheet(
        side: ShadSheetSide.left,
        context: context,
        builder: (context) => const DrawerPage(side: ShadSheetSide.left),
      );
    }

     void _onHistoryPressed() {
      showShadSheet(
        side: ShadSheetSide.right,
        context: context,
        builder: (context) => const HistoryPage(side: ShadSheetSide.right),
      );
    }

    return Scaffold(
      ///
      /// APP BAR
      ///
      appBar: MyAppBar(
        title: 'REST API Client',
        leading: IconButton(
          onPressed: () => _onMenuPressed(),
          icon: const Icon(AppIcons.menuIcon),
        ),
        actions: [
          IconButton(onPressed: () => _onHistoryPressed(), icon: const Icon(AppIcons.historyIcon)),
        ],
      ),

      /// BODY
      body: const Center(child: Text('Welcome to the Home Page!')),
    );
  }
}
