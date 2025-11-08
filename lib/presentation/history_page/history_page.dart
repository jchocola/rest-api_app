import 'package:api_client/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.side});

  final ShadSheetSide side;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadSheet(
      title: const Text('History'),
      description: const Text(
        "View your past API requests here.",
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: List.generate(5, (index) => HistoryCard())
      ),
     // actions: const [ShadButton(child: Text('Save changes'))],
    ));
  }
}
