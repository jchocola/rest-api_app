import 'package:api_client/bloc/responses_bloc.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/data/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryResponseCard extends StatelessWidget {
  const HistoryResponseCard({
    super.key,
    this.onTap,
    required this.responseModel,
  });
  final void Function()? onTap;
  final ResponseModel responseModel;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          // SlidableAction(
          //   // An action can be bigger than the others.
          //   // flex: 2,
          //   onPressed: (context) {},
          //   // backgroundColor: Color(0xFF7BC043),
          //   // foregroundColor: Colors.white,
          //   icon: AppIcons.callIcon,
          //   label: 'Call',
          // ),
          // SlidableAction(
          //   // An action can be bigger than the others.
          //   // flex: 2,
          //   onPressed: (context) {},
          //   // backgroundColor: Color(0xFF7BC043),
          //   // foregroundColor: Colors.white,
          //   icon: AppIcons.reuseIcon,
          //   label: 'Re-use',
          // ),
          SlidableAction(
            onPressed: (context) {
              context.read<ResponsesBloc>().add(
                ResponsesBlocEvent_delete_response(response: responseModel),
              );
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
          width: double.infinity,
          title: Text(responseModel.body, maxLines: 2),
          description: Text(responseModel.statusCode.toString()),
          trailing: ShadBadge.secondary(child: const Text('200 OK')),
        ),
      ),
    );
  }
}
