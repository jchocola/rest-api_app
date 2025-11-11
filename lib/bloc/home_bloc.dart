// ignore_for_file: dangling_library_doc_comments, camel_case_types
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api_client/core/constant/app_constant.dart';
import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/data/model/parameter_model.dart';
import 'package:api_client/main.dart';

///
/// HOME BLOC - USING FOR CONTROL HOME_PAGE STATE AND DATA FOR REQUEST
///

///
/// EVENTS
///
abstract class HomeBlocEvent {}

class HomeBlocEvent_Init extends HomeBlocEvent {}

class HomeBlocEvent_ChangeHttpMethod extends HomeBlocEvent {
  final HTTP_METHOD method;
  HomeBlocEvent_ChangeHttpMethod({required this.method});
}

class HomeBlocEvent_ChangeTabIndex extends HomeBlocEvent {
  final String tabIndex;
  HomeBlocEvent_ChangeTabIndex({required this.tabIndex});
}

class HomeBlocEvent_ChangeEndPointUrl extends HomeBlocEvent {
  final String value;
  HomeBlocEvent_ChangeEndPointUrl({required this.value});
}

class HomeBlocEvent_add_new_query_parameter extends HomeBlocEvent {}

class HomeBlocEvent_change_query_checkbox_value extends HomeBlocEvent {
  final int queryParamIndex;
  HomeBlocEvent_change_query_checkbox_value({required this.queryParamIndex});
}

class HomeBlocEvent_change_query_parameter_name extends HomeBlocEvent {
  final int queryParamIndex;
  final String parameterName;
  HomeBlocEvent_change_query_parameter_name({
    required this.queryParamIndex,
    required this.parameterName,
  });
}

class HomeBlocEvent_change_query_parameter_value extends HomeBlocEvent {
  final int queryParamIndex;
  final String parameterValue;
  HomeBlocEvent_change_query_parameter_value({
    required this.queryParamIndex,
    required this.parameterValue,
  });
}

class HomeBlocEvent_add_new_header_parameter extends HomeBlocEvent {}

class HomeBlocEvent_change_header_checkbox_value extends HomeBlocEvent {
  final int headerParamIndex;
  HomeBlocEvent_change_header_checkbox_value({required this.headerParamIndex});
}

class HomeBlocEvent_change_header_parameter_name extends HomeBlocEvent {
  final int headerParamIndex;
  final String parameterName;
  HomeBlocEvent_change_header_parameter_name({
    required this.headerParamIndex,
    required this.parameterName,
  });
}

class HomeBlocEvent_change_header_parameter_value extends HomeBlocEvent {
  final int headerParamIndex;
  final String parameterValue;
  HomeBlocEvent_change_header_parameter_value({
    required this.headerParamIndex,
    required this.parameterValue,
  });
}

class HomeBlocEvent_change_auth_index extends HomeBlocEvent {
  final String authIndex;
  HomeBlocEvent_change_auth_index({required this.authIndex});
}

class HomeBLocEvent_change_basic_auth_username extends HomeBlocEvent {
  final String username;
  HomeBLocEvent_change_basic_auth_username({required this.username});
}

class HomeBLocEvent_change_basic_auth_password extends HomeBlocEvent {
  final String password;
  HomeBLocEvent_change_basic_auth_password({required this.password});
}

class HomeBLocEvent_change_bearer_auth_token extends HomeBlocEvent {
  final String token;
  HomeBLocEvent_change_bearer_auth_token({required this.token});
}

class HomeBLocEvent_change_bearer_auth_token_prefix extends HomeBlocEvent {
  final String tokenPrefix;
  HomeBLocEvent_change_bearer_auth_token_prefix({required this.tokenPrefix});
}

class HomeBLocEvent_change_oauth2_token_prefix extends HomeBlocEvent {
  final String tokenPrefix;
  HomeBLocEvent_change_oauth2_token_prefix({required this.tokenPrefix});
}

class HomeBLocEvent_change_oauth2_access_token extends HomeBlocEvent {
  final String token;
  HomeBLocEvent_change_oauth2_access_token({required this.token});
}

class HomeBlocEvent_change_body_index extends HomeBlocEvent {
  final String bodyIndex;
  HomeBlocEvent_change_body_index({required this.bodyIndex});
}

///
/// STATES
///
abstract class HomeBlocState {}

class HomeBlocState_Initial extends HomeBlocState {}

class HomeBlocState_Loaded extends HomeBlocState {
  // varaibles
  final HTTP_METHOD currentMethod; // http method
  final String endpoint; // url endpoint
  final String tabIndex; // tab index (query-header-auth-body)
  final String bodyTabIndex; // JSON - XML
  final String bodyContent; // body content
  final String authTabIndex; // auth tab index  (none- basic- bearer - oauth2)

  final List<ParameterModel> queryParameters; // query parameters
  final List<ParameterModel> headerParameters; // header parameters
  final String? username; // auth basic user name
  final String? password; // auth basic password

  final String? bearerToken; // auth bearer token
  final String? bearerTokenPrefix; // auth bearer token prefix

  final String? oauth2AccessToken; // auth oauth2 access token
  final String? oauth2TokenPrefix; // auth oatuh token prefix

  HomeBlocState_Loaded({
    required this.currentMethod,
    required this.endpoint,
    required this.tabIndex,
    required this.bodyContent,
    required this.bodyTabIndex,
    required this.headerParameters,
    required this.queryParameters,
    required this.authTabIndex,
    this.username,
    this.password,
    this.bearerToken,
    this.bearerTokenPrefix = 'Bearer',

    this.oauth2TokenPrefix = 'Bearer',
    this.oauth2AccessToken,
  });

  HomeBlocState_Loaded copyWith({
    HTTP_METHOD? currentMethod,
    String? endpoint,
    String? tabIndex,
    String? bodyTabIndex,
    String? bodyContent,
    List<ParameterModel>? queryParameters,
    List<ParameterModel>? headerParameters,
    String? authTabIndex,
    String? username,
    String? password,
    String? bearerToken,
    String? bearerTokenPrefix,

    String? oauth2TokenPrefix,
    String? oauth2AccessToken,
  }) {
    return HomeBlocState_Loaded(
      currentMethod: currentMethod ?? this.currentMethod,
      endpoint: endpoint ?? this.endpoint,
      tabIndex: tabIndex ?? this.tabIndex,
      bodyTabIndex: bodyTabIndex ?? this.bodyTabIndex,
      bodyContent: bodyContent ?? this.bodyContent,
      queryParameters: queryParameters ?? this.queryParameters,
      headerParameters: headerParameters ?? this.headerParameters,
      authTabIndex: authTabIndex ?? this.authTabIndex,
      username: username ?? this.username,
      password: password ?? this.password,
      bearerToken: bearerToken ?? this.bearerToken,
      bearerTokenPrefix: bearerTokenPrefix ?? this.bearerTokenPrefix,

      oauth2AccessToken: oauth2AccessToken ?? this.oauth2AccessToken,
      oauth2TokenPrefix: oauth2TokenPrefix ?? this.oauth2TokenPrefix,
    );
  }
}

class HomeBlocState_Loading extends HomeBlocState {}

class HomeBlocState_Error extends HomeBlocState {
  final String error;
  HomeBlocState_Error({required this.error});
}

class HomeBlocState_Success extends HomeBlocState {
  final String title;
  HomeBlocState_Success({required this.title});
}

///
/// HOME_BLOC
///

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(HomeBlocState_Initial()) {
    ///
    /// HOME BLOC EVENT _ INIT
    ///
    on<HomeBlocEvent_Init>((event, emit) {
      // SET DEFAULT DATA
      emit(
        HomeBlocState_Loaded(
          currentMethod: HTTP_METHOD.GET,
          endpoint: '',
          tabIndex: AppConstant.tab_query,
          bodyContent: '',
          bodyTabIndex: AppConstant.tab_json,
          headerParameters: [],
          queryParameters: [],
          authTabIndex: AppConstant.tab_none,
          username: null,
          password: null,
          bearerToken: null,
          oauth2AccessToken: null,
        ),
      );

      logger.i('Home Bloc inited');
    });

    ///
    /// HOME BLOC EVENT - CHANGE TAB INDEX
    ///
    on<HomeBlocEvent_ChangeTabIndex>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        emit(currentState.copyWith(tabIndex: event.tabIndex));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE HTTP METHOD
    ///

    on<HomeBlocEvent_ChangeHttpMethod>((event, emit) {
      final currentState = state;

      if (currentState is HomeBlocState_Loaded) {
        emit(currentState.copyWith(currentMethod: event.method));
      }

      logger.i('Changed method : current method is ${event.method}');
    });

    ///
    /// HOME BLOC EVENT - CHANGE ENDPOINT URL
    ///
    on<HomeBlocEvent_ChangeEndPointUrl>((event, emit) {
      final currentState = state;
      logger.i('Current endpoint value : ${event.value}');
      if (currentState is HomeBlocState_Loaded) {
        emit(currentState.copyWith(endpoint: event.value));
      }
    });

    ///
    /// HOME BLOC EVENT - ADD NEW QUERY PARAMETER Tapped
    ///
    on<HomeBlocEvent_add_new_query_parameter>((event, emit) {
      final currentState = state;

      logger.i('Added new query parameter');
      if (currentState is HomeBlocState_Loaded) {
        final queryParams = currentState.queryParameters;
        queryParams.add(
          ParameterModel(isSelected: false, parameter: '', value: ''),
        );

        emit(currentState.copyWith(queryParameters: queryParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE CHECK BOX VALUE
    ///
    on<HomeBlocEvent_change_query_checkbox_value>((event, emit) {
      final currentState = state;

      logger.i('Changed checkbox value - index : ${event.queryParamIndex}');
      if (currentState is HomeBlocState_Loaded) {
        final queryParams = currentState.queryParameters;

        final updated = queryParams[event.queryParamIndex].copyWith(
          isSelected: !queryParams[event.queryParamIndex].isSelected,
        );

        queryParams[event.queryParamIndex] = updated;

        emit(currentState.copyWith(queryParameters: queryParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE QUERY PARAMETER NAME
    ///
    on<HomeBlocEvent_change_query_parameter_name>((event, emit) {
      final currentState = state;

      logger.i(
        'Changed parameter name - index : ${event.queryParamIndex} - ${event.parameterName}',
      );
      if (currentState is HomeBlocState_Loaded) {
        final queryParams = currentState.queryParameters;

        final updated = queryParams[event.queryParamIndex].copyWith(
          parameter: event.parameterName,
        );

        queryParams[event.queryParamIndex] = updated;

        emit(currentState.copyWith(queryParameters: queryParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE QUERY PARAMETER NAME
    ///
    on<HomeBlocEvent_change_query_parameter_value>((event, emit) {
      final currentState = state;

      logger.i(
        'Changed parameter value - index : ${event.queryParamIndex} - ${event.parameterValue}',
      );
      if (currentState is HomeBlocState_Loaded) {
        final queryParams = currentState.queryParameters;

        final updated = queryParams[event.queryParamIndex].copyWith(
          value: event.parameterValue,
        );

        queryParams[event.queryParamIndex] = updated;

        emit(currentState.copyWith(queryParameters: queryParams));
      }
    });

    ///
    /// HOME BLOC EVENT - ADD NEW HEADER PARAMETER Tapped
    ///
    on<HomeBlocEvent_add_new_header_parameter>((event, emit) {
      final currentState = state;

      logger.i('Added new header parameter');
      if (currentState is HomeBlocState_Loaded) {
        final headerParams = currentState.headerParameters;
        headerParams.add(
          ParameterModel(isSelected: false, parameter: '', value: ''),
        );

        emit(currentState.copyWith(headerParameters: headerParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE CHECK BOX VALUE
    ///
    on<HomeBlocEvent_change_header_checkbox_value>((event, emit) {
      final currentState = state;

      logger.i(
        'Changed checkbox header value - index : ${event.headerParamIndex}',
      );
      if (currentState is HomeBlocState_Loaded) {
        final headerParams = currentState.headerParameters;

        final updated = headerParams[event.headerParamIndex].copyWith(
          isSelected: !headerParams[event.headerParamIndex].isSelected,
        );

        headerParams[event.headerParamIndex] = updated;

        emit(currentState.copyWith(headerParameters: headerParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE HEADER PARAMETER NAME
    ///
    on<HomeBlocEvent_change_header_parameter_name>((event, emit) {
      final currentState = state;

      logger.i(
        'Changed header parameter name - index : ${event.headerParamIndex} - ${event.parameterName}',
      );
      if (currentState is HomeBlocState_Loaded) {
        final queryParams = currentState.headerParameters;

        final updated = queryParams[event.headerParamIndex].copyWith(
          parameter: event.parameterName,
        );

        queryParams[event.headerParamIndex] = updated;

        emit(currentState.copyWith(headerParameters: queryParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE HEADER PARAMETER VALUE
    ///
    on<HomeBlocEvent_change_header_parameter_value>((event, emit) {
      final currentState = state;

      logger.i(
        'Changed HEADER parameter  value - index : ${event.headerParamIndex} - ${event.parameterValue}',
      );
      if (currentState is HomeBlocState_Loaded) {
        final headerParams = currentState.headerParameters;

        final updated = headerParams[event.headerParamIndex].copyWith(
          value: event.parameterValue,
        );

        headerParams[event.headerParamIndex] = updated;

        emit(currentState.copyWith(headerParameters: headerParams));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE TAB INDEX
    ///
    on<HomeBlocEvent_change_auth_index>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        emit(currentState.copyWith(authTabIndex: event.authIndex));
      }
    });

    ///
    ///  HOME BLOC EVENT - CHANGE BASIC AUTH USER NAME
    ///
    on<HomeBLocEvent_change_basic_auth_username>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        logger.i('Change basic auth user name - ${event.username}');

        emit(currentState.copyWith(username: event.username));
      }
    });

    ///
    ///  HOME BLOC EVENT - CHANGE BASIC AUTH USER NAME
    ///
    on<HomeBLocEvent_change_basic_auth_password>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        logger.i('Change basic auth password - ${event.password}');

        emit(currentState.copyWith(password: event.password));
      }
    });

    ///
    ///  HOME BLOC EVENT - CHANGE BASIC AUTH USER NAME
    ///
    on<HomeBLocEvent_change_bearer_auth_token>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        logger.i('Change bearer auth token - ${event.token}');

        emit(currentState.copyWith(bearerToken: event.token));
      }
    });

    ///
    ///  HOME BLOC EVENT - CHANGE BASIC AUTH USER NAME
    ///
    on<HomeBLocEvent_change_bearer_auth_token_prefix>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        logger.i('Change bearer auth token prefix - ${event.tokenPrefix}');

        emit(currentState.copyWith(bearerTokenPrefix: event.tokenPrefix));
      }
    });

    ///
    ///  HOME BLOC EVENT - CHANGE BASIC AUTH USER NAME
    ///
    on<HomeBLocEvent_change_oauth2_token_prefix>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        logger.i('Change  oauth2 token prefix - ${event.tokenPrefix}');

        emit(currentState.copyWith(oauth2TokenPrefix: event.tokenPrefix));
      }
    });

    ///
    ///  HOME BLOC EVENT - CHANGE OAUTH2 ACCESS TOKEN
    ///
    on<HomeBLocEvent_change_oauth2_access_token>((event, emit) {
      final currentState = state;
      if (currentState is HomeBlocState_Loaded) {
        logger.i('Change oauth2 acces token - ${event.token}');

        emit(currentState.copyWith(oauth2AccessToken: event.token));
      }
    });

    ///
    /// HOME BLOC EVENT - CHANGE BODY INDEX
    ///
    on<HomeBlocEvent_change_body_index>((event, emit) {
      final currentState = state;

      logger.i('Change body tab : ${event.bodyIndex}');
      if (currentState is HomeBlocState_Loaded) {
        emit(currentState.copyWith(bodyTabIndex: event.bodyIndex));
      }
    });
  }
}
