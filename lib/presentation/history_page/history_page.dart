import 'package:api_client/bloc/responses_bloc.dart';
import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/presentation/response_page/response_page.dart';
import 'package:api_client/widgets/history_card.dart';
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
          spacing: 16,
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
        return Text('Requests');
      case AppConstant.tab_response:
        return buildResponses(context);

      default:
        return SizedBox();
    }
  }

  Widget buildResponses(context) {
    return BlocBuilder<ResponsesBloc, ResponsesBlocState>(
      builder: (context, state) {
        if (state is ResponsesBlocState_loaded) {
          return Text('We have data');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
