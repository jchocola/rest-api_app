import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/data/model/parameter_model.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ParameterCard extends StatelessWidget {
  ParameterCard({
    super.key,
    this.parameter,
    this.onCheckBoxChanged,
    this.onParameterNameChanged,
    this.onParameterValueChanged,
  });
  final ParameterModel? parameter;
  void Function(bool)? onCheckBoxChanged;
  void Function(String)? onParameterNameChanged;
  void Function(String)? onParameterValueChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstant.appPadding / 2),
      child: Row(
        children: [
          ShadCheckbox(
            value: parameter?.isSelected ?? false,
            onChanged: onCheckBoxChanged,
          ),
          const SizedBox(width: AppConstant.appPadding),
          Expanded(
            flex: 1,
            child: ShadInput(
             initialValue: parameter?.parameter,
              placeholder:  Text('Parameter'),
              onChanged: onParameterNameChanged,
            ),
          ),
          const SizedBox(width: AppConstant.appPadding),
          Expanded(
            flex: 2,
            child: ShadInput(
              initialValue: parameter?.value,
              placeholder:   Text('Value') ,
              onChanged: onParameterValueChanged,
            ),
          ),
        ],
      ),
    );
  }
}
