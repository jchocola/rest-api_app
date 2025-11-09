import 'package:api_client/core/icons/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KeyCard extends StatelessWidget {
  const KeyCard({super.key ,});

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
            icon: AppIcons.editIcon,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {},
            //backgroundColor: Color(0xFF0392CF),
            // foregroundColor: Colors.white,
            icon: AppIcons.deleteIcon,
            label: 'Delete',
          ),
        ],
      ),
      child: ShadCard(
        width: double.infinity,
        title: Text('GEMINI_KEY'),
        trailing: ShadButton.ghost(child: Icon(AppIcons.copyIcon)),

        child: Text('8594-5893-8593-3923'),
      ),
    );
  }
}
