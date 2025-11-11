import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/main.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthParametersWidget extends StatefulWidget {
  const AuthParametersWidget({super.key});

  @override
  State<AuthParametersWidget> createState() => _AuthParametersWidgetState();
}

class _AuthParametersWidgetState extends State<AuthParametersWidget> {
  //String selectedTab = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is HomeBlocState_Loaded) {
              return ShadTabs(
                //  controller: _tabsController,
                scrollable: true,
                onChanged: (value) {
                  context.read<HomeBloc>().add(
                    HomeBlocEvent_change_auth_index(authIndex: value),
                  );
                  logger.i('Selected tab: $value');
                },
                value: state.authTabIndex,
                tabs: [
                  ShadTab(
                    value: AppConstant.tab_none,
                    child: Center(child: Text('None')),
                  ),
                  ShadTab(
                    value: AppConstant.tab_basic,
                    child: Center(child: Text('Basic')),
                  ),
                  ShadTab(
                    value: AppConstant.tab_bearer,
                    child: Center(child: Text('Bearer')),
                  ),
                  ShadTab(
                    value: AppConstant.tab_oauth2,
                    child: Center(child: Text('OAuth2')),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        const SizedBox(height: AppConstant.appPadding),

        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      builder: (context, state) {
        if (state is HomeBlocState_Loaded) {
          switch (state.authTabIndex) {
            case AppConstant.tab_none:
              return const Text('No Authentication Selected');
            case AppConstant.tab_basic:
              return _basic(context);
            case AppConstant.tab_bearer:
              return _bearer(context);
            case AppConstant.tab_oauth2:
              return _oauth2(context);
            default:
              return const Center(child: Text('Select a tab'));
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _basic(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Basic Authentication'),
        ShadInput(
          placeholder: Text('Username'),
          keyboardType: TextInputType.emailAddress,
        ),

        ShadInput(
          placeholder: Text('Password'),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _bearer(context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bearer Token'),
        ShadTextarea(placeholder: Text('Enter token')),

        Row(
          children: [
            Text('Token prefix'),
            SizedBox(width: AppConstant.appPadding / 2),
            Flexible(
              child: ShadInput(
                initialValue: 'Bearer',
                placeholder: Text('Bearer'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _oauth2(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('OAuth Authentication'),
        Row(
          children: [
            Text('Token prefix'),
            SizedBox(width: AppConstant.appPadding / 2),
            Flexible(
              child: ShadInput(
                initialValue: 'Bearer',
                placeholder: Text('Bearer'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Access token'),
            SizedBox(width: AppConstant.appPadding / 2),
            Flexible(
              child: ShadInput(
                // initialValue: '',
                placeholder: Text('enter token'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
