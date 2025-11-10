import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/main.dart';
import 'package:api_client/presentation/about_us_page/about_us_page.dart';
import 'package:api_client/presentation/faq_page/faq_page.dart';
import 'package:api_client/presentation/feed_back_page/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key, required this.side});

  final ShadSheetSide side;

  void _onShareAppTapped() async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(text: 'check out my website https://example.com'),
      );

      if (result.status == ShareResultStatus.success) {
        logger.i('Thank you for sharing my website!');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> _rateUsTapped() async {
    final _url =
        'https://play.google.com/store/apps/dev?id=6563729752241674835';
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

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
                onPressed: () => context.push('/keys'),
              ),

              ShadButton.ghost(
                leading: Icon(AppIcons.rateUsIcon),
                child: Text('Rate us'),
                onPressed: () => _rateUsTapped(),
              ),

              ShadButton.ghost(
                leading: Icon(AppIcons.shareIcon),
                child: Text('Share app'),
                onPressed: _onShareAppTapped,
              ),

              ShadButton.ghost(
                leading: Icon(AppIcons.privacyIcon),
                child: Text('Privacy policy'),
              ),

              ShadButton.ghost(
                leading: Icon(AppIcons.faqsIcon),
                onPressed: () => context.push('/faq'),
                child: Text('FAQs'),
              ),

              ShadButton.ghost(
                leading: Icon(AppIcons.feedbackIcon),
                child: Text('Feedback'),
                onPressed: () {
                  showShadDialog(
                    context: context,
                    builder: (context) => FeedbackPage(),
                  );
                },
              ),

              ShadButton.ghost(
                leading: Icon(AppIcons.aboutUsIcon),
                child: Text('About Us'),
                onPressed: () {
                  showShadDialog(
                    context: context,
                    builder: (context) => AboutUsPage(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
