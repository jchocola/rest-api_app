import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key, required this.side});

  final ShadSheetSide side;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * AppConstant.drawerWidthFactor,
      child: ShadSheet(
        // constraints: BoxConstraints(
        //   maxWidth: size.width * AppConstant.drawerWidthFactor,
        // ),
        title: const Text('REST API Client'),
        // description: const Text(
        //   "Make changes to your profile here. Click save when you're done",
        // ),

        // actions: const [ShadButton(child: Text('Save changes'))],

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            spacing: 16,
            children: [
              ShadButton.ghost(
                leading: Icon(AppIcons.keyIcon),
                child: Text('Keys'),
              ),

               ShadButton.ghost(
                leading: Icon(AppIcons.rateUsIcon),
                child: Text('Rate us'),
              ),

               ShadButton.ghost(
                leading: Icon(AppIcons.shareIcon),
                child: Text('Share app'),
              ),

               ShadButton.ghost(
                leading: Icon(AppIcons.privacyIcon),
                child: Text('Privacy policy'),
              ),

               ShadButton.ghost(
                leading: Icon(AppIcons.faqsIcon),
                child: Text('FAQs'),
              ),

               ShadButton.ghost(
                leading: Icon(AppIcons.feedbackIcon),
                child: Text('Feedback'),
              ),

               ShadButton.ghost(
                leading: Icon(AppIcons.aboutUsIcon),
                child: Text('About Us'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
