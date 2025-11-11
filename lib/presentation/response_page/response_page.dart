import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/main.dart';
import 'package:api_client/presentation/response_page/widgets/header_viewer_widget.dart';
import 'package:api_client/presentation/response_page/widgets/response_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({super.key});

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  String selectedTab = 'Response';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  AppConstant.appPadding),
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
    return ShadTabs(
      //  controller: _tabsController,
      scrollable: true,
      onChanged: (value) {
        setState(() {
          selectedTab = value;
        });
        logger.i('Selected tab: $value');
      },
      value: selectedTab,
      tabs: [
        ShadTab(
          value: 'Response',
          child: Center(child: Text('Response')),
        ),
        ShadTab(
          value: 'Headers',
          child: Center(child: Text('Headers')),
        ),
       
        ShadTab(
          value: 'Cookies',
          child: Center(child: Text('Cookies')),
        ),
      ],
    );
  }

  Widget _buidContent(context) {
    switch (selectedTab) {
      case 'Response':
        return ResponseViewerWidget();
      case 'Headers':
        return HeaderViewerWidget();
      case 'Cookies':
        return ResponseViewerWidget();
      default:
        return SizedBox();
    }
  }

  Widget _buildRequestBody() {
    return Row(
      children: [
        // method selector
        Expanded(
          flex: 1,
          child: ShadButton.ghost(child: Text('GET'),)
        ),
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
