import 'package:api_client/core/icons/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, this.onTap});
  final  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Slidable(
       endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
           SlidableAction(
            // An action can be bigger than the others.
            // flex: 2,
            onPressed: (context) {},
            // backgroundColor: Color(0xFF7BC043),
            // foregroundColor: Colors.white,
            icon: AppIcons.callIcon,
            label: 'Call',
          ),
          SlidableAction(
            // An action can be bigger than the others.
            // flex: 2,
            onPressed: (context) {},
            // backgroundColor: Color(0xFF7BC043),
            // foregroundColor: Colors.white,
            icon: AppIcons.reuseIcon,
            label: 'Re-use',
          ),
          SlidableAction(
            onPressed: (context) {
            
            },
            //backgroundColor: Color(0xFF0392CF),
            // foregroundColor: Colors.white,
            icon: AppIcons.deleteIcon,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ShadCard(
          title: const Text('https://api.example.com/data', maxLines: 2),
          description: const Text('GET • 2024-06-15 14:30'),
          trailing: ShadBadge.secondary(child: const Text('200 OK')),
        ),
      ),
    );
  }
}
