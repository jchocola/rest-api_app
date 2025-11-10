import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text('About us'),
      child: Column(
        children: [
          _info(title: 'Application', value: 'REST API Client'),
          _info(title: 'Developer', value: 'Nguen T.B'),
          _info(title: 'Email', value: 'email@.com'),
          _info(title: 'Version', value: '1.2.3'),
        ],
      ),
    );
  }

  Widget _info({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
