import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            ShadButton.ghost(
              child: Icon(AppIcons.addIcon),
              onPressed: () => context.read<HomeBloc>().add(
                HomeBlocEvent_add_new_query_parameter(),
              ),
            ),
          ],
        ),
        // Add your query parameters input fields here
        BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is HomeBlocState_Loaded) {
              return Column(
                children: List.generate(
                  state.queryParameters.length,
                  (index) => ParameterCard(
                    parameter: state.queryParameters[index],
                    onParameterNameChanged: (value) {
                      context.read<HomeBloc>().add(
                        HomeBlocEvent_change_query_parameter_name(
                          queryParamIndex: index,
                          parameterName: value,
                        ),
                      );
                    },

                    onParameterValueChanged: (value) {
                      context.read<HomeBloc>().add(
                        HomeBlocEvent_change_query_parameter_value(
                          queryParamIndex: index,
                          parameterValue: value,
                        ),
                      );
                    },
                    onCheckBoxChanged: (value) => context.read<HomeBloc>().add(
                      HomeBlocEvent_change_query_checkbox_value(
                        queryParamIndex: index,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
