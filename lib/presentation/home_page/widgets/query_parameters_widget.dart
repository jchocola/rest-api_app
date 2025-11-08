import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';

class QueryParametersWidget extends StatelessWidget {
  const QueryParametersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Query Parameters'),
        // Add your query parameters input fields here
        ...List.generate(50, (index) => ParameterCard()),
      ],
    );
  }
}
