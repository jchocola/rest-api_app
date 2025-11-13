import 'package:api_client/bloc/responses_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/widgets/empty_widget.dart';
import 'package:api_client/widgets/history_request_card.dart';
import 'package:api_client/widgets/history_response_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.side});

  final ShadSheetSide side;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String index = AppConstant.tab_requests;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadSheet(
      title: const Text('History'),
      description: const Text("View your past API requests here."),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppConstant.appPadding,
          children: [
            ShadTabs(
              //  controller: _tabsController,
              scrollable: true,
              onChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              value: index,
              tabs: [
                ShadTab(
                  value: AppConstant.tab_requests,
                  child: Center(child: Text('Requests')),
                ),
                ShadTab(
                  value: AppConstant.tab_response,
                  child: Center(child: Text('Responses')),
                ),
              ],
            ),

            buildContent(context),
          ],
          // children: List.generate(
          //   5,
          //   (index) => HistoryCard(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => ResponsePage()),
          //       );
          //     },
          //   ),
          // ),
        ),
        // actions: const [ShadButton(child: Text('Save changes'))],
      ),
    );
  }

  Widget buildContent(context) {
    switch (index) {
      case AppConstant.tab_requests:
        return buildRequests(context);
      case AppConstant.tab_response:
        return buildResponses(context);

      default:
        return SizedBox();
    }
  }

  Widget buildRequests(context) {
    return Column(
       spacing: AppConstant.appPadding, 
      children: List.generate(5, (index) => HistoryRequestCard()));
  }

  Widget buildResponses(context) {
    return BlocBuilder<ResponsesBloc, ResponsesBlocState>(
      builder: (context, state) {
        if (state is ResponsesBlocState_loaded) {
          if (state.responses.isEmpty) {
            return EmptyWidget();
          } else {
            return SlidableAutoCloseBehavior(
              child: Column(
                spacing: AppConstant.appPadding,
                children: List.generate(state.responses.length, (index) {
                  return HistoryResponseCard(
                    responseModel: state.responses[index],
                  );
                }),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
