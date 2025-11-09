import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/data/model/faq_model.dart';
import 'package:api_client/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'FAQs'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            _security_privacy_part(context),
            _data_storage_part(context),
            _functionality_part(context),
            _technical_questions_part(context),
            _troubleshooting_part(context),
            _legal_questions_part(context),
            _general_questions_part(context)


          ],
        ),
      ),
    );
  }

  //🔒 Security & Privacy
  Widget _security_privacy_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: 'Where are my API keys and tokens stored?',
        a: "All sensitive data (tokens, keys, passwords) are stored in your device's secure storage (Secure Storage) that uses system-level encryption mechanisms. This data is not accessible to other applications.",
      ),
      FAQModel(
        q: "Can other applications access my request history?",
        a: "No. All application data (request history, settings) is stored locally on your device in isolated storage and is not accessible to other applications.",
      ),
      FAQModel(
        q: "Is my data transmitted to your servers?",
        a: "No. The application works completely offline. All requests are sent directly to your API endpoints, and results are saved only on your device.",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🔒 Security & Privacy'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }

  //💾 Data Storage
  Widget _data_storage_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: 'Where are my requests and history saved?',
        a: "Request history is saved in a local database on your device. Data never leaves your device.",
      ),
      FAQModel(
        q: "What happens to my data if I uninstall the app?",
        a: "When you uninstall the app, all local data (request history, settings, tokens) will be permanently deleted. We recommend exporting important requests before uninstalling.",
      ),
      FAQModel(
        q: "Can I sync data between devices?",
        a: " In the current version, synchronization between devices is not available. Each device stores its separate request history.",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('💾 Data Storage'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }

  //📱 Functionality
  Widget _functionality_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: 'What authentication types are supported?',
        a: """
    Supported authentication methods include:
    - Bearer Token
    - OAuth 2.0
    - Basic Auth
    - API Keys via headers
""",
      ),
      FAQModel(
        q: "Can I import/export request collections?",
        a: "Yes, you can export request collections to JSON files and import them back for backup or manual transfer to another device.",
      ),
      FAQModel(
        q: "Are passwords and tokens saved when exporting?",
        a: "No, when exporting collections, sensitive data (passwords, tokens) is excluded from the file for security reasons.",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('📱 Functionality'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }



  //🔧 Technical Questions
  Widget _technical_questions_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: "Does the app require an internet connection?",
        a: "The application itself works offline, but an internet connection is required to execute API requests.",
      ),
      FAQModel(
        q: "What data formats are supported?",
        a: """
  Supported formats include:
    - JSON (with syntax highlighting and formatting)
    - Text responses
    -Support for various Content-Type headers
  """,
      ),
      FAQModel(
        q: "Is there a limit on saved history size?",
        a: "There is no fixed limit, but the amount of stored data depends on your device's available storage space.",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🔧 Technical Questions'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }


  //🛠️ Troubleshooting
  Widget _troubleshooting_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: "I uninstalled and reinstalled the app. Can I restore my request history?",
        a: "Unfortunately, no. When you uninstall the app, all local data is deleted without recovery options.",
      ),
      FAQModel(
        q: "New requests aren't saving to history. What should I do?",
        a: "Check if you have sufficient storage space on your device. Also try restarting the application.",
      ),
      FAQModel(
        q: "Authentication tokens aren't saving. What's the issue?",
        a: " Make sure the app has necessary permissions to access secure storage. Some devices may have restrictions.",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🛠️ Troubleshooting'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }


   //📄 Legal Questions
  Widget _legal_questions_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: "How is my data processed?",
        a: "We do not collect or process your personal data. All API requests are executed directly from your device to the services you specify.",
      ),
      FAQModel(
        q: "Does the app comply with GDPR/data protection laws?",
        a: "Yes, since all data is stored locally on your device and not transmitted to third parties, the app fully complies with data protection requirements.",
      ),
      FAQModel(
        q: "Authentication tokens aren't saving. What's the issue?",
        a: " Make sure the app has necessary permissions to access secure storage. Some devices may have restrictions.",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('📄 Legal Questions'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }


     //❓ General Questions
  Widget _general_questions_part(context) {
    final List<FAQModel> qa = [
      FAQModel(
        q: "Is there a web version or desktop version of the app?",
        a: "Currently the application is only available for mobile devices.",
      ),
      FAQModel(
        q: " How can I suggest a new feature or report a bug?",
        a: "You can submit feedback through our in-app form or contact support through the official channel.",
      ),
      FAQModel(
        q: "What happens if my device is lost or stolen?",
        a: "Since all data is stored locally and encrypted on your device, your API credentials and request history remain protected. However, we recommend revoking any active tokens from your API providers as an additional security measure.",
      ),

      FAQModel(q: "Can I password-protect the app?", a: "The current version doesn't include app-level password protection, but all sensitive data is stored in encrypted secure storage. App locking features are planned for future updates.")
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('❓ General Questions'),
        ShadAccordion<int>(
          children: List.generate(
            qa.length,
            (index) => ShadAccordionItem(
              value: index,
              title: Text(qa[index].q),
              child: Text(qa[index].a),
            ),
          ),
        ),
      ],
    );
  }


}
