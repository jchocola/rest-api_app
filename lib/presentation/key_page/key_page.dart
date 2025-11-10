import 'package:api_client/bloc/key_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/core/icons/app_icon.dart';
import 'package:api_client/main.dart';
import 'package:api_client/presentation/key_page/widgets/creating_key_page.dart';
import 'package:api_client/widgets/app_bar.dart';
import 'package:api_client/widgets/key_card.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  State<KeyPage> createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> with TickerProviderStateMixin {
  void _onCreateTapped() {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return SizedBox(
          height: size.height * 0.7,
          width: size.width,
          child: CreatingKeyPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: _onCreateTapped,
        child: Icon(AppIcons.addIcon),
      ),
      appBar: MyAppBar(title: 'Key Storage'),
      body: SlidableAutoCloseBehavior(child: _buildBody(context)),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
        child: BlocConsumer<KeyBloc, KeyBlocState>(
          ///
          /// listener
          ///
          listener: (context, state) {
            if (state is KeyBlocError) {
              logger.e(state.eror);
                ElegantNotification.error(
                title: Text("Update"),
                description: Text(state.eror),
               
              ).show(context); 
            } else if (state is KeyBlocSuccess) {
              logger.t(state.title);
              ElegantNotification.success(
                title: Text("Update"),
                description: Text(state.title),
                
              ).show(context);
            }
          },

          ///
          ///  builder
          ///
          builder: (context, state) {
            if (state is KeyBlocLoaded) {
              return Column(
                spacing: AppConstant.appPadding / 2,
                children: List.generate(
                  state.keys.length,
                  (index) => KeyCard(keyModel: state.keys[index]),
                ),
              );
            } else if (state is KeyBlocLoading) {
              return CircularProgressIndicator();
            } else if (state is KeyBlocError) {
              return Text(state.eror);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
