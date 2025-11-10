import 'package:api_client/bloc/key_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/data/model/key_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreatingKeyPage extends StatefulWidget {
  CreatingKeyPage({super.key});

  @override
  State<CreatingKeyPage> createState() => _CreatingKeyPageState();
}

class _CreatingKeyPageState extends State<CreatingKeyPage> {
  final key_name_controller = TextEditingController();

  final key_value_controller = TextEditingController();

 @override
  void dispose() {
    key_name_controller.dispose();
    key_value_controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    void _onSaveTapped() async {
      // generate new key model
      final newKeyModel = KeyModel(
        name: key_name_controller.text,
        value: key_value_controller.text,
      );

      context.read<KeyBloc>().add(KeyBlocEvent_saveNewKey(newKey: newKeyModel));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          Text('Add New Key'),
          ShadInput(
            controller: key_name_controller,
            placeholder: Text('KEY_NAME'),
            //keyboardType: TextInputType.emailAddress,
          ),

          ShadInput(
            controller: key_value_controller,
            placeholder: Text('KEY_VALUE'),
            //keyboardType: TextInputType.emailAddress,
          ),

          Spacer(),
          SafeArea(
            child: ShadButton.secondary(
              width: double.infinity,
              onPressed: _onSaveTapped,
              child: BlocConsumer<KeyBloc, KeyBlocState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is KeyBlocLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return Text('Save');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
