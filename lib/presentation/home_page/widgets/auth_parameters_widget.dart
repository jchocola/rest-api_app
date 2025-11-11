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
       ShadTextarea(
        placeholder: Text('Enter token'),
       ),

        Row(
          children: [
            Text('Token prefix'),
            SizedBox(width: AppConstant.appPadding/2,),
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
            SizedBox(width: AppConstant.appPadding/2,),
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
            SizedBox(width: AppConstant.appPadding/2,),
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
