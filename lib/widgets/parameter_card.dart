import 'package:api_client/core/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ParameterCard extends StatelessWidget {
  const ParameterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstant.appPadding/2),
      child: Row(
        children: [
          ShadCheckbox(value: true),
          const SizedBox(width: AppConstant.appPadding),
          Expanded(
            flex: 1,
            child: ShadInput(
              placeholder: Text('parameter'),
                  
            ),
          ),
          const SizedBox(width: AppConstant.appPadding),
          Expanded(
            flex: 2,
            child: ShadInput(
               placeholder: Text('value'),
            
            ),
          ),
        ],
      ),
    );
  }
}
