import 'package:api_client/main.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BodyParametersWidget extends StatefulWidget {
  const BodyParametersWidget({super.key});

  @override
  State<BodyParametersWidget> createState() => _BodyParametersWidgetState();
}

class _BodyParametersWidgetState extends State<BodyParametersWidget> {
  String selectedTab = 'json';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ShadTabs(
          //  controller: _tabsController,
          scrollable: true,
          onChanged: (value) {
            setState(() {
              selectedTab = value;
            });
            logger.i('Selected tab: $value');
          },
          value: selectedTab,
          tabs: [
            ShadTab(
              value: 'json',
              child: Center(child: Text('JSON')),
            ),
            ShadTab(
              value: 'xml',
              child: Center(child: Text('XML')),
            ),
            // ShadTab(
            //   value: 'Auth',
            //   child: Center(child: Text('Auth')),
            // ),
            // ShadTab(
            //   value: 'Body',
            //   child: Center(child: Text('Body')),
            // ),
          ],
        ),

        ///
        ///
        ///
        ShadTextarea(minHeight: size.height * 0.5),
      ],
    );
  }
}
