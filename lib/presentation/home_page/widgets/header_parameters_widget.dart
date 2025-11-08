import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';

class HeaderParameterWidget extends StatelessWidget {
  const HeaderParameterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Header Parameters'),
        // Add your query parameters input fields here
        ...List.generate(55, (index) => ParameterCard()),
      ],
    );
  }
}
