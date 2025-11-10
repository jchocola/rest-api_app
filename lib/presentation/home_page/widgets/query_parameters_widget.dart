import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QueryParametersWidget extends StatelessWidget {
  const QueryParametersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Query Parameters'),
            ShadButton.ghost(child: Icon(AppIcons.addIcon),)
          ],
        ),
        // Add your query parameters input fields here
        ...List.generate(50, (index) => ParameterCard()),
      ],
    );
  }
}
