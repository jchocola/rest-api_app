import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/widgets/app_bar.dart';
import 'package:api_client/widgets/key_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  State<KeyPage> createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Key Storage'),
      body: SlidableAutoCloseBehavior(child: _buildBody(context)),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding / 2,
          children: List.generate(15, (index) => KeyCard()),
        ),
      ),
    );
  }
}
