// ignore_for_file: camel_case_types

import 'package:api_client/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api_client/core/constant/app_constant.dart';

/// RESPONSE BLOC - USING FOR CONTROL REPOSNSE PAGE
// ignore_for_file: dangling_library_doc_comments

///
/// RESPONSE EVENT
///
abstract class ResponseBlocEvent {}

class ResponseEvent_init extends ResponseBlocEvent {}

class ResponseEvent_change_tab_index extends ResponseBlocEvent {
  final String value;
  ResponseEvent_change_tab_index({required this.value});
}

///
/// RESPONSE STATE
///
abstract class ResponseBlocState {}

class ResponseState_initial extends ResponseBlocState {}

class ResponseState_loading extends ResponseBlocState {}

class ResponseState_loaded extends ResponseBlocState {
  final String tabIndex;
  ResponseState_loaded({required this.tabIndex});

  ResponseState_loaded copyWith({String? tabIndex}) {
    return ResponseState_loaded(tabIndex: tabIndex ?? this.tabIndex);
  }
}

class ResponseState_success extends ResponseBlocState {}

class ResponseState_error extends ResponseBlocState {}

///
/// RESPONSE BLOC
///
class ResponseBloc extends Bloc<ResponseBlocEvent, ResponseBlocState> {
  ResponseBloc() : super(ResponseState_initial()) {
    ///
    /// RESPONSE EVENT INIT
    ///
    on<ResponseEvent_init>((event, emit) {
      logger.i('Response Event Init');
      emit(ResponseState_loaded(tabIndex: AppConstant.tab_response));
    });

    ///
    /// RESPONSE EVET - CHANGE TAB INDEX VALUE
    ///
    on<ResponseEvent_change_tab_index>((event, emit) {
      final currentState = state;

      logger.i('RESPONSE EVENT - change tab index value ${event.value}');
      if (currentState is ResponseState_loaded) {
        emit(currentState.copyWith(tabIndex: event.value));
      }
    });
  }
}
