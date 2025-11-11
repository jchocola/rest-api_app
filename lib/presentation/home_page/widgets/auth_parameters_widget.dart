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

  Widget _basic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Basic Authentication'),
        BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is HomeBlocState_Loaded) {
              return ShadInput(
                initialValue: state.username,
                placeholder: Text('Username'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  context.read<HomeBloc>().add(
                    HomeBLocEvent_change_basic_auth_username(username: value),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is HomeBlocState_Loaded) {
              return ShadInput(
                initialValue: state.password,
                placeholder: Text('Password'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  context.read<HomeBloc>().add(
                    HomeBLocEvent_change_basic_auth_password(password: value),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _bearer(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bearer Token'),
        BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is HomeBlocState_Loaded) {
              return ShadTextarea(
                initialValue: state.bearerToken,
                placeholder: Text('Enter token'),
                onChanged: (value) {
                  logger.i('UI: bearerToken onChanged -> $value');
                  context.read<HomeBloc>().add(
                    HomeBLocEvent_change_bearer_auth_token(token: value),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        Row(
          children: [
            Text('Token prefix'),
            SizedBox(width: AppConstant.appPadding / 2),
            Flexible(
              child: BlocBuilder<HomeBloc, HomeBlocState>(
                builder: (context, state) {
                  if (state is HomeBlocState_Loaded) {
                    return ShadInput(
                      key: ValueKey('bearerTokenPrefix'),
                      initialValue: state.bearerTokenPrefix,
                      placeholder: Text('Bearer'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        logger.i('UI: bearerTokenPrefix onChanged -> $value');
                        context.read<HomeBloc>().add(
                          HomeBLocEvent_change_bearer_auth_token_prefix(
                            tokenPrefix: value,
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
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
              child: BlocBuilder<HomeBloc, HomeBlocState>(
                builder: (context, state) {
                  if (state is HomeBlocState_Loaded) {
                    return ShadInput(
                      initialValue: state.oauth2TokenPrefix,
                      placeholder: Text('Bearer'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        logger.i('UI: oauth2TokenPrefix onChanged -> $value');
                        context.read<HomeBloc>().add(
                          HomeBLocEvent_change_oauth2_token_prefix(
                            tokenPrefix: value,
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Access token'),
            SizedBox(width: AppConstant.appPadding / 2),
            Flexible(
              child: BlocBuilder<HomeBloc, HomeBlocState>(
                builder: (context, state) {
                  if (state is HomeBlocState_Loaded) {
                    return ShadInput(
                      key: ValueKey('oauth2AccessToken'),
                      initialValue: state.oauth2AccessToken,
                      placeholder: Text('Enter token'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                          logger.i('UI: oauth2AccessToken onChanged -> $value');
                        context.read<HomeBloc>().add(
                          HomeBLocEvent_change_oauth2_access_token(
                            token: value,
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
