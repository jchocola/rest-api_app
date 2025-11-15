import 'package:api_client/bloc/response_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestParamsWidget extends StatelessWidget {
  const RequestParamsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponsePageBloc, ResponsePageBlocState>(
      builder: (context, state) {
        if (state is ResponsePageState_loaded) {
          return SelectableText(state.selectedResponse?.parameters.toString() ?? '' , textAlign: TextAlign.start,);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
