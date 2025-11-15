import 'dart:convert';

import 'package:api_client/bloc/response_page_bloc.dart';
import 'package:api_client/presentation/response_info_page/response_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_json_preview/interactive_json_preview.dart';

class ResponseViewerWidget extends StatelessWidget {
  ResponseViewerWidget({super.key});

  final Map<String, Map<String, Object>> data = {
    "author": {
      "name": "Yeikel",
      "lastName": "Uriarte",
      "github_username": "@yeikel16",
      "age": 24,
      "developer": true,
      "height": 186.5,
      "projects": [
        {
          "owner": {
            "username": "yeikel16",
            "avatar_url":
                "https://avatars.githubusercontent.com/u/26438532?v=4",
          },
          "id": 447347774,
          "node_id": "R_kgDOGqn8Pg",
          "name": "deta-dart",
          "url": "https://api.github.com/users/yeikel16",
          "created_at": "2022-01-12T19:37:58Z",
          "updated_at": "2024-05-08T07:44:11Z",
          "pushed_at": "2022-12-30T00:27:01Z",
          "git_url": "git://github.com/yeikel16/deta-dart.git",
          "ssh_url": "git@github.com:yeikel16/deta-dart.git",
          "clone_url": "https://github.com/yeikel16/deta-dart.git",
          "svn_url": "https://github.com/yeikel16/deta-dart",
          "license": {
            "key": "gpl-3.0",
            "name": "GNU General Public License v3.0",
            "spdx_id": "GPL-3.0",
            "url": "https://api.github.com/licenses/gpl-3.0",
            "node_id": "MDc6TGljZW5zZTk=",
          },
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    //return InteractiveJsonPreview(data: data);

    return BlocBuilder<ResponsePageBloc, ResponsePageBlocState>(
      builder: (context, state) {
        if (state is ResponsePageState_loaded) {
          return Text(
              state.selectedResponse!.body,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
