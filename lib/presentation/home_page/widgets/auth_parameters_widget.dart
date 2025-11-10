import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/main.dart';
import 'package:api_client/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthParametersWidget extends StatefulWidget {
  const AuthParametersWidget({super.key});

  @override
  State<AuthParametersWidget> createState() => _AuthParametersWidgetState();
}

class _AuthParametersWidgetState extends State<AuthParametersWidget> {
  String selectedTab = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              value: 'None',
              child: Center(child: Text('None')),
            ),
            ShadTab(
              value: 'Basic',
              child: Center(child: Text('Basic')),
            ),
            ShadTab(
              value: 'Bearer',
              child: Center(child: Text('Bearer')),
            ),
            ShadTab(
              value: 'OAuth2',
              child: Center(child: Text('OAuth2')),
            ),
          ],
        ),

        const SizedBox(height: AppConstant.appPadding),

        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (selectedTab) {
      case 'None':
        return const Text('No Authentication Selected');
      case 'Basic':
        return _basic(context);
      case 'Bearer':
        return _bearer(context);
      case 'OAuth2':
        return _oauth2(context);
      default:
        return const Center(child: Text('Select a tab'));
    }
  }

  Widget _basic(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic Authentication'),
        ParameterCard(),
        ParameterCard(),
      ],
    );
  }

  Widget _bearer(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Bearer Token'), ShadTextarea(), ParameterCard()],
    );
  }


  Widget _oauth2(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OAuth Authentication'),
        ParameterCard(),
        ParameterCard(),
      ],
    );
  }
}
