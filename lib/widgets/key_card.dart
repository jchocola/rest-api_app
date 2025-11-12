import 'package:api_client/bloc/key_bloc.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/data/model/key_model.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KeyCard extends StatelessWidget {
  const KeyCard({super.key, required this.keyModel});
  final KeyModel keyModel;

  @override
  Widget build(BuildContext context) {
    void _copyTapped() {
      Clipboard.setData(ClipboardData(text: keyModel.value)).then((value) {
        ElegantNotification.success(
          description: Text('Copied key'),
        ).show(context);
      });
    }

    void _onDeleteTapped() {
      context.read<KeyBloc>().add(KeyBlocEvent_deleteKey(key: keyModel));
    }

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
          //   icon: AppIcons.editIcon,
          //   label: 'Edit',
          // ),
          SlidableAction(
            onPressed: (context) {
              _onDeleteTapped();
            },
            //backgroundColor: Color(0xFF0392CF),
            // foregroundColor: Colors.white,
            icon: AppIcons.deleteIcon,
            label: 'Delete',
          ),
        ],
      ),
      child: ShadCard(
        width: double.infinity,
        title: Text(keyModel.name , maxLines: 1,),
        trailing: ShadButton.ghost(child: Icon(AppIcons.copyIcon), onPressed: _copyTapped,),

        child: Text(keyModel.value, maxLines: 2, overflow: TextOverflow.fade,),
      ),
    );
  }
}
