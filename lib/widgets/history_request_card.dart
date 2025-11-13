import 'package:api_client/bloc/responses_bloc.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/data/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryRequestCard extends StatelessWidget {
  const HistoryRequestCard({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
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
            onPressed: (context) {},
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
          width: double.infinity,
          title: Text('https://coin.com', maxLines: 2, ),
          description: Text('6 days ago'),
          trailing: ShadBadge.secondary(child: const Text('GET')),
        ),
      ),
    );
  }
}
