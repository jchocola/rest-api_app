import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';

class HeaderViewerWidget extends StatelessWidget {
  const HeaderViewerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index)=> ParameterCard()),
    );
  }
}
