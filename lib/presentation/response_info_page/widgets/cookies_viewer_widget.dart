import 'package:api_client/bloc/response_page_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CookiesViewerWidget extends StatelessWidget {
  const CookiesViewerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponsePageBloc, ResponsePageBlocState>(
      builder: (context, state) {
        if (state is ResponsePageState_loaded) {
          return SingleChildScrollView( child: SelectableText(state.selectedResponse?.cookies ?? ''));
        } else {
          return CircularProgressIndicator();
        }
      },
    );

    // return Column(
    //   children: List.generate(3, (index)=> ParameterCard()),
    // );
  }
}