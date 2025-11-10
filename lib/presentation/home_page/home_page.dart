import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/main.dart';
import 'package:api_client/presentation/drawer_page/drawer_page.dart';
import 'package:api_client/presentation/history_page/history_page.dart';
import 'package:api_client/presentation/home_page/widgets/auth_parameters_widget.dart';
import 'package:api_client/presentation/home_page/widgets/body_parameters_widget.dart';
import 'package:api_client/presentation/home_page/widgets/header_parameters_widget.dart';
import 'package:api_client/presentation/home_page/widgets/query_parameters_widget.dart';
import 'package:api_client/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final fruits = {
  'get': 'GET',
  'post': 'POST',
  'put': 'PUT',
  'delete': 'DELETE',
  'PATCH': 'PATCH',
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ShadTabsController _tabsController = ShadTabsController<String>(
  //   value: 'Query',
  // );

  String selectedTab = 'Query';

  @override
  Widget build(BuildContext context) {
    void _onMenuPressed() {
      showShadSheet(
        side: ShadSheetSide.left,
        context: context,
        builder: (context) => const DrawerPage(side: ShadSheetSide.left),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        children: [
          SizedBox(height: AppConstant.appPadding / 2),

          // methods and input fields will go here
          Row(
            children: [
              // method selector
              Expanded(
                flex: 1,
                child: ShadSelect<String>(
                  placeholder: const Text('POST'),
                  options: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
                    //   child: Text('Methods', textAlign: TextAlign.start),
                    // ),
                    ...fruits.entries.map(
                      (e) => ShadOption(value: e.key, child: Text(e.value)),
                    ),
                  ],
                  selectedOptionBuilder: (context, value) =>
                      Text(fruits[value]!),
                  onChanged: print,
                ),
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
          ),

          const SizedBox(height: AppConstant.appPadding),
          ////
          ///
          ///
          // rest of the body content
          ShadTabs(
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
                value: 'Query',
                child: Center(child: Text('Query')),
              ),
              ShadTab(
                value: 'Headers',
                child: Center(child: Text('Headers')),
              ),
              ShadTab(
                value: 'Auth',
                child: Center(child: Text('Auth')),
              ),
              ShadTab(
                value: 'Body',
                child: Center(child: Text('Body')),
              ),
            ],
          ),

          const SizedBox(height: AppConstant.appPadding),
          // content based on selected tab
          Expanded(child: SingleChildScrollView(child: _buildContent(context))),

          const SizedBox(height: AppConstant.appPadding),
          // Send Request Button
          SafeArea(
            child: ShadButton(
              child: const Text('Send Request'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (selectedTab) {
      case 'Query':
        return const QueryParametersWidget();
      case 'Headers':
        return const HeaderParameterWidget();
      case 'Auth':
        return const AuthParametersWidget();
      case 'Body':
        return const BodyParametersWidget();
      default:
        return const Center(child: Text('Select a tab'));
    }
  }
}
