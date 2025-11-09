import 'package:api_client/core/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreatingKeyPage extends StatelessWidget {
  const CreatingKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          Text('Add New Key'),
          ShadInput(
            placeholder: Text('KEY_NAME'),
            keyboardType: TextInputType.emailAddress,
          ),
      
          ShadInput(
            placeholder: Text('KEY_VALUE'),
            keyboardType: TextInputType.emailAddress,
          ),

          Spacer(),
          SafeArea(child: ShadButton.secondary(child: Text('Save'),width: double.infinity,))
        ],
      ),
    );
  }
}
