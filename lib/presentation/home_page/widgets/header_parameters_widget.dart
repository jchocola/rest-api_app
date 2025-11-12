import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HeaderParameterWidget extends StatelessWidget {
  const HeaderParameterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      builder: (context, state) {
        if (state is HomeBlocState_Loaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Header Parameters'),
                  ShadButton.ghost(
                    child: Icon(AppIcons.addIcon),
                    onPressed: () => context.read<HomeBloc>().add(
                      HomeBlocEvent_add_new_header_parameter(),
                    ),
                  ),
                ],
              ),
              // Add your query parameters input fields here
              ...List.generate(
                state.headerParameters.length,
                (index) => ParameterCard(
                  parameter: state.headerParameters[index],
                  onParameterNameChanged: (value) =>
                      context.read<HomeBloc>().add(
                        HomeBlocEvent_change_header_parameter_name(
                          headerParamIndex: index,
                          parameterName: value,
                        ),
                      ),
                  onParameterValueChanged: (value) =>
                      context.read<HomeBloc>()..add(
                        HomeBlocEvent_change_header_parameter_value(
                          headerParamIndex: index,
                          parameterValue: value,
                        ),
                      ),
                  onCheckBoxChanged: (value) => context.read<HomeBloc>()
                    ..add(
                      HomeBlocEvent_change_header_checkbox_value(
                        headerParamIndex: index,
                      ),
                    ),
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
