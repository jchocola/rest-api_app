import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BodyParametersWidget extends StatefulWidget {
  const BodyParametersWidget({super.key});

  @override
  State<BodyParametersWidget> createState() => _BodyParametersWidgetState();
}

class _BodyParametersWidgetState extends State<BodyParametersWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is HomeBlocState_Loaded) {
              return ShadTabs(
                scrollable: true,
                onChanged: (value) {
                  context.read<HomeBloc>().add(
                    HomeBlocEvent_change_body_index(bodyIndex: value),
                  );
                },
                value: state.bodyTabIndex,
                tabs: [
                  ShadTab(
                    value: AppConstant.tab_json,
                    child: Center(child: Text('JSON')),
                  ),
                  ShadTab(
                    value: AppConstant.tab_xml,
                    child: Center(child: Text('XML')),
                  ),
                  // ShadTab(
                  //   value: 'Auth',
                  //   child: Center(child: Text('Auth')),
                  // ),
                  // ShadTab(
                  //   value: 'Body',
                  //   child: Center(child: Text('Body')),
                  // ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        ///
        ///
        ///
        ShadTextarea(minHeight: size.height * 0.5),
      ],
    );
  }
}
