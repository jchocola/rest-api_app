import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: const Text('https://api.example.com/data' , maxLines: 2,),
      description:const  Text('GET • 2024-06-15 14:30'),
      trailing: ShadBadge.secondary(child: const Text('200 OK')),
    );
  }
}



