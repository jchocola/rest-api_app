// ignore_for_file: camel_case_types

import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api_client/core/constant/app_constant.dart';

/// RESPONSE BLOC - USING FOR CONTROL REPOSNSE PAGE
// ignore_for_file: dangling_library_doc_comments

///
/// RESPONSE EVENT
///
abstract class ResponsePageBlocEvent {}

class ResponsePageEvent_init extends ResponsePageBlocEvent {}

class ResponsePageEvent_change_tab_index extends ResponsePageBlocEvent {
  final String value;
  ResponsePageEvent_change_tab_index({required this.value});
}

class ResponsePageEvent_set_responsemodel extends ResponsePageBlocEvent {
  final ResponseModel model;
  ResponsePageEvent_set_responsemodel({required this.model});
}

///
/// RESPONSE STATE
///
abstract class ResponsePageBlocState {}

class ResponsePageState_initial extends ResponsePageBlocState {}

class ResponsePageState_loading extends ResponsePageBlocState {}

class ResponsePageState_loaded extends ResponsePageBlocState {
  final String tabIndex;
  final ResponseModel? selectedResponse;
  ResponsePageState_loaded({required this.tabIndex, this.selectedResponse});

  ResponsePageState_loaded copyWith({
    String? tabIndex,
    ResponseModel? responseModel,
  }) {
    return ResponsePageState_loaded(
      tabIndex: tabIndex ?? this.tabIndex,
      selectedResponse: responseModel ?? this.selectedResponse,
    );
  }
}

class ResponsePageState_success extends ResponsePageBlocState {}

class ResponsePageState_error extends ResponsePageBlocState {}

///
/// RESPONSE BLOC
///
class ResponsePageBloc
    extends Bloc<ResponsePageBlocEvent, ResponsePageBlocState> {
  ResponsePageBloc() : super(ResponsePageState_initial()) {
    ///
    /// RESPONSE EVENT INIT
    ///
    on<ResponsePageEvent_init>((event, emit) {
      logger.i('Response Event Init');
      emit(ResponsePageState_loaded(tabIndex: AppConstant.tab_response));
    });

    ///
    /// RESPONSE EVET - CHANGE TAB INDEX VALUE
    ///
    on<ResponsePageEvent_change_tab_index>((event, emit) {
      final currentState = state;

      logger.i('RESPONSE EVENT - change tab index value ${event.value}');
      if (currentState is ResponsePageState_loaded) {
        emit(currentState.copyWith(tabIndex: event.value));
      }
    });

      ///
    /// RESPONSE EVET - SET RESPONSE MODEL
    ///
    on<ResponsePageEvent_set_responsemodel>((event, emit) {
      final currentState = state;

      logger.i('RESPONSE EVENT - SET RESPONSE MODEL ${event.model}');
      if (currentState is ResponsePageState_loaded) {
        emit(currentState.copyWith(responseModel: event.model));
      }
    });
  }
}
