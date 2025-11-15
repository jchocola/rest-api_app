import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/bloc/key_bloc.dart';
import 'package:api_client/bloc/request_bloc.dart';
import 'package:api_client/bloc/history_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/core/utils/parameter_list_formatter.dart';
import 'package:api_client/core/utils/response_size_calculator.dart';
import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/main.dart';
import 'package:api_client/presentation/drawer_page/drawer_page.dart';
import 'package:api_client/presentation/history_page/history_page.dart';
import 'package:api_client/presentation/home_page/widgets/auth_parameters_widget.dart';
import 'package:api_client/presentation/home_page/widgets/body_parameters_widget.dart';
import 'package:api_client/presentation/home_page/widgets/header_parameters_widget.dart';
import 'package:api_client/presentation/home_page/widgets/query_parameters_widget.dart';
import 'package:api_client/widgets/app_bar.dart';
import 'package:api_client/widgets/empty_widget.dart';
import 'package:api_client/widgets/key_card.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_json_preview/interactive_json_preview.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/uuid.dart';

// final fruits = {
//   'get': 'GET',
//   'post': 'POST',
//   'put': 'PUT',
//   'delete': 'DELETE',
//   'PATCH': 'PATCH',
// };

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final endpointController = TextEditingController();
  final endpointMethodController = TextEditingController();
  // String selectedTab = 'Query';

  @override
  Widget build(BuildContext context) {
    void _onMenuPressed() {
      showShadSheet(
        side: ShadSheetSide.left,
        context: context,
        builder: (context) => const DrawerPage(side: ShadSheetSide.left),
      );
    }

    void _onKeyTapped() {
      showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (context) {
          return BlocBuilder<KeyBloc, KeyBlocState>(
            builder: (context, state) {
              if (state is KeyBlocLoaded) {
                if (state.keys.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstant.appPadding,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: AppConstant.appPadding / 2,
                        children: List.generate(
                          state.keys.length,
                          (index) => KeyCard(keyModel: state.keys[index]),
                        ),
                      ),
                    ),
                  );
                } else {
                  return EmptyWidget();
                }
              } else {
                return EmptyWidget();
              }
            },
          );
        },
      );
    }

    void _onHistoryPressed() {
      showShadSheet(
        side: ShadSheetSide.right,
        context: context,
        builder: (context) => const HistoryPage(side: ShadSheetSide.right),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        ///
        /// APP BAR
        ///
        appBar: MyAppBar(
          title: 'REST API Client',
          leading: IconButton(
            onPressed: () => _onMenuPressed(),
            icon: const Icon(AppIcons.menuIcon),
          ),
          actions: [
            /// KEY BUTTON
            IconButton(
              onPressed: () => _onKeyTapped(),
              icon: const Icon(AppIcons.keyIcon),
            ),

            /// HISTORY BUTTON
            IconButton(
              onPressed: () => _onHistoryPressed(),
              icon: const Icon(AppIcons.historyIcon),
            ),
          ],
        ),

        /// BODY
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        children: [
          SizedBox(height: AppConstant.appPadding / 2),
          ShadInput(
            controller: endpointController,
            onChanged: (value) => context.read<HomeBloc>().add(
              HomeBlocEvent_ChangeEndPointUrl(value: value),
            ),
            placeholder: Text('https://jsonplaceholder.typicode.com'),
          ),
          SizedBox(height: AppConstant.appPadding / 2),
          // methods and input fields will go here
          Row(
            children: [
              // method selector
              Expanded(
                flex: 1,
                child: ShadSelect<String>(
                  placeholder: BlocBuilder<HomeBloc, HomeBlocState>(
                    builder: (context, state) {
                      if (state is HomeBlocState_Loaded) {
                        return Text(state.currentMethod.name);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  options: [
                    ...HTTP_METHOD.values.map(
                      (e) => ShadOption(value: e.name, child: Text(e.name)),
                    ),
                  ],
                  selectedOptionBuilder: (context, value) =>
                      BlocBuilder<HomeBloc, HomeBlocState>(
                        builder: (context, state) {
                          if (state is HomeBlocState_Loaded) {
                            return Text(state.currentMethod.name);
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                  onChanged: (value) {
                    context.read<HomeBloc>().add(
                      HomeBlocEvent_ChangeHttpMethod(
                        method: httpMethodConvertFromString(value: value!),
                      ),
                    );
                  },
                ),
              ),
              // input fields
              const SizedBox(width: AppConstant.appPadding),
              Expanded(
                flex: 3,
                child: ShadInput(
                  controller: endpointMethodController,
                  onChanged: (value) => context.read<HomeBloc>().add(
                    HomeBlocEvent_ChangeEndPointMethodUrl(value: value),
                  ),
                  placeholder: Text('/todos/1'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstant.appPadding),
          ////
          ///
          ///
          // rest of the body content
          BlocBuilder<HomeBloc, HomeBlocState>(
            builder: (context, state) {
              if (state is HomeBlocState_Loaded) {
                return ShadTabs(
                  //  controller: _tabsController,
                  scrollable: true,
                  onChanged: (value) {
                    context.read<HomeBloc>().add(
                      HomeBlocEvent_ChangeTabIndex(tabIndex: value),
                    );
                    logger.i('Selected tab: $value');
                  },
                  value: state.tabIndex,
                  tabs: [
                    ShadTab(
                      value: AppConstant.tab_query,
                      child: Center(child: Text('Query')),
                    ),
                    ShadTab(
                      value: AppConstant.tab_headers,
                      child: Center(child: Text('Headers')),
                    ),
                    // ShadTab(
                    //   value: AppConstant.tab_auth,
                    //   child: Center(child: Text('Auth')),
                    // ),
                    ShadTab(
                      value: AppConstant.tab_body,
                      child: Center(child: Text('Body')),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),

          const SizedBox(height: AppConstant.appPadding),
          // content based on selected tab
          Expanded(child: SingleChildScrollView(child: _buildContent(context))),

          const SizedBox(height: AppConstant.appPadding),

          // Send Request Button
          SafeArea(
            child: BlocBuilder<HomeBloc, HomeBlocState>(
              builder: (context, homeBlocState) {
                if (homeBlocState is HomeBlocState_Loaded) {
                  return BlocConsumer<RequestBloc, RequestBlocState>(
                    listener: (context, state) {
                      if (state is RequestBlocState_Error) {
                        ElegantNotification.error(
                          displayCloseButton: true,
                          showProgressIndicator: false,
                          toastDuration: AppConstant.errorToastDuration,
                          title: Text('Check passed parameters again'),
                          action: ShadButton.secondary(
                            child: Text('Save Request'),
                          ),
                          description: Text(state.error, maxLines: 20),
                          height: 500,
                        ).show(context);
                      } else if (state is RequestBlocState_Success) {
                        logger.i('GET RESPONSE');
                        ElegantNotification.success(
                          notificationMargin: AppConstant.appPadding,
                          displayCloseButton: true,
                          action: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShadButton.secondary(
                                onPressed: () =>
                                    context.read<HistoryBloc>().add(
                                      HistoryBlocEvent_save_response(
                                        responseTime: state.responseTime,
                                        currentMethod:
                                            homeBlocState.currentMethod,
                                        params: parameterListFormatter2(
                                          paramsList:
                                              homeBlocState.queryParameters,
                                        ),
                                        response: state.response,
                                      ),
                                    ),
                                padding: EdgeInsets.all(
                                  AppConstant.appPadding / 2,
                                ),
                                child: Text('Save response'),
                              ),
                              ShadButton.secondary(
                                padding: EdgeInsets.all(
                                  AppConstant.appPadding / 2,
                                ),
                                child: Text('Save Request'),
                              ),
                            ],
                          ),
                          showProgressIndicator: true,
                          toastDuration: AppConstant.errorToastDuration,
                          title: Row(
                            spacing: AppConstant.appPadding,
                            children: [
                              Text(state.response.statusCode.toString()),
                              Text(state.response.statusMessage.toString()),
                              Text(
                                calculateTotalResponseSize(
                                      state.response,
                                    ).toString() +
                                    'bytes',
                              ),

                              Text('${state.responseTime} ms'),
                            ],
                          ),
                          description: SizedBox(
                            width: 500,
                            height: 500,
                            child: InteractiveJsonPreview(
                              data: state.response.data,
                            ),
                          ),
                          //description: Text(state.response.data.toString(), maxLines: 20,),
                          height: size.height * 0.8,
                          width: size.width * 0.8,
                        ).show(context);
                      }
                    },

                    builder: (context, state) {
                      if (state is RequestBlocState_Initial) {
                        return ShadButton(
                          child: const Text('Send Request'),
                          onPressed: () {
                            /// get full path request
                            final requestFullPath =
                                homeBlocState.endpoint +
                                homeBlocState.endpointMethod;

                            /// generate request model
                            final RequestModel request = RequestModel(
                              id: Uuid().v4().substring(0, 8),
                              queryParameters: parameterListFormatter(
                                paramsList: homeBlocState.queryParameters,
                              ),
                              httpMethod: homeBlocState.currentMethod,
                              url: requestFullPath,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              body: homeBlocState.bodyContent,
                              username: homeBlocState.username,
                              password: homeBlocState.password,
                              bearerToken: homeBlocState.bearerToken,
                              bearerTokenPrefix:
                                  homeBlocState.bearerTokenPrefix,
                              oauthToken: homeBlocState.oauth2AccessToken,
                              oauthTokenPrefix: homeBlocState.oauth2TokenPrefix,
                              headers: parameterListFormatter(
                                paramsList: homeBlocState.headerParameters,
                              ),
                            );

                            /// send request model to request bloc
                            context.read<RequestBloc>().add(
                              RequestBlocEvent_make_request(
                                requestModel: request,
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
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
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      builder: (context, state) {
        if (state is HomeBlocState_Loaded) {
          switch (state.tabIndex) {
            case AppConstant.tab_query:
              return const QueryParametersWidget();
            case AppConstant.tab_headers:
              return const HeaderParameterWidget();
            case AppConstant.tab_auth:
              return const AuthParametersWidget();
            case AppConstant.tab_body:
              return const BodyParametersWidget();
            default:
              return const Center(child: Text('Select a tab'));
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
