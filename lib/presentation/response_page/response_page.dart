import 'package:api_client/bloc/response_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/presentation/response_page/widgets/header_viewer_widget.dart';
import 'package:api_client/presentation/response_page/widgets/response_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({super.key});

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  // String selectedTab = 'Response';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        children: [
          // Status info
          _buildStatus(context),
          SizedBox(height: AppConstant.appPadding),
          _buildRequestBody(),
          SizedBox(height: AppConstant.appPadding),
          _buildTab(context),
          SizedBox(height: AppConstant.appPadding),
          Expanded(child: _buidContent(context)),
          Row(
            spacing: AppConstant.appPadding,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShadButton.secondary(child: Text('Call again')),
              ShadButton.secondary(child: Text('Re-use')),
              ShadButton.secondary(child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatus(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ShadBadge.secondary(
          child: Column(children: [Text('Status'), Text('200')]),
        ),
        ShadBadge.secondary(
          child: Column(children: [Text('Size'), Text('43.5KB')]),
        ),
        ShadBadge.secondary(
          child: Column(children: [Text('Times'), Text('0.32s')]),
        ),
      ],
    );
  }

  Widget _buildTab(context) {
    return BlocBuilder<ResponseBloc, ResponseBlocState>(
      builder: (context, state) {
        if (state is ResponseState_loaded) {
          return ShadTabs(
            scrollable: true,
            onChanged: (value) {
              context.read<ResponseBloc>().add(
                ResponseEvent_change_tab_index(value: value),
              );
            },
            value: state.tabIndex,
            tabs: [
              ShadTab(
                value: AppConstant.tab_response,
                child: Center(child: Text('Response')),
              ),
              ShadTab(
                value: AppConstant.tab_headers,
                child: Center(child: Text('Headers')),
              ),

              ShadTab(
                value: AppConstant.tab_cookies,
                child: Center(child: Text('Cookies')),
              ),

              ShadTab(
                value: AppConstant.tab_request_params,
                child: Center(child: Text('Request Parameters')),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buidContent(context) {
    return BlocBuilder<ResponseBloc, ResponseBlocState>(
      builder: (context, state) {
        if (state is ResponseState_loaded) {
          switch (state.tabIndex) {
            case AppConstant.tab_response:
              return ResponseViewerWidget();
            case AppConstant.tab_headers:
              return HeaderViewerWidget();
            case AppConstant.tab_cookies:
              return ResponseViewerWidget();
            case AppConstant.tab_request_params:
              return ResponseViewerWidget();
            default:
              return SizedBox();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildRequestBody() {
    return Row(
      children: [
        // method selector
        Expanded(flex: 1, child: ShadButton.ghost(child: Text('GET'))),
        // input fields
        const SizedBox(width: AppConstant.appPadding),
        Expanded(
          flex: 3,
          child: ShadInput(
            placeholder: Text('URL'),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}
