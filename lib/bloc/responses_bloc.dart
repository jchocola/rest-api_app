// ignore_for_file: camel_case_types

import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/data/repository/local_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// RESPONSES BLOC = USING FOR CONTROL SAVED RESPONSED

// ignore_for_file: dangling_library_doc_comments

///
/// RESPONSES BLOC EVENT
///
abstract class ResponsesBlocEvent {}

class ResponsesBlocEvent_init extends ResponsesBlocEvent {}

class ResponsesBlocEvent_save_response extends ResponsesBlocEvent {
  final Response response;

  ResponsesBlocEvent_save_response({required this.response});
}

///
/// RESPONSES BLOC STATE
///

abstract class ResponsesBlocState {}

class ResponsesBlocState_initial extends ResponsesBlocState {}

class ResponsesBlocState_loading extends ResponsesBlocState {}

class ResponsesBlocState_loaded extends ResponsesBlocState {
  final List<ResponseModel> responses;

  ResponsesBlocState_loaded({required this.responses});
}

class ResponsesBlocState_error extends ResponsesBlocState {}

///
/// RESPONSES BLOC
///

class ResponsesBloc extends Bloc<ResponsesBlocEvent, ResponsesBlocState> {
  final LocalStorageRepository responsesLocalStorageRepo;
  ResponsesBloc({required this.responsesLocalStorageRepo})
    : super(ResponsesBlocState_initial()) {
    ///
    /// RESPONSE BLOC EVENT - INIT
    ///
    on<ResponsesBlocEvent_init>((event, emit) async {
      try {
        final responseList = await responsesLocalStorageRepo.getAllResponse();
        emit(ResponsesBlocState_loaded(responses: responseList));
      } catch (e) {
        emit(ResponsesBlocState_error());
      }
    });

    on<ResponsesBlocEvent_save_response>((event, emit) async{
      try {
        final ResponseModel responseModel = ResponseModel(
          requestId: '1',
          statusCode: event.response.statusCode ?? 200,
          headersJson: event.response.headers.toString(),
          body: event.response.extra.toString(),
          size: 434,
          responseTimeMs: 424,
        );

        await responsesLocalStorageRepo.insertData(response: responseModel);
      } catch (e) {
        emit(ResponsesBlocState_error());
      } finally {
        add(ResponsesBlocEvent_init());
      }
    });
  }
}
