// ignore_for_file: camel_case_types

import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/core/utils/parameter_list_formatter.dart';
import 'package:api_client/core/utils/response_size_calculator.dart';
import 'package:api_client/data/model/parameter_model.dart';
import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/data/repository/local_storage_repository.dart';
import 'package:api_client/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

/// RESPONSES BLOC = USING FOR CONTROL SAVED RESPONSED

// ignore_for_file: dangling_library_doc_comments

///
/// RESPONSES BLOC EVENT
///
abstract class ResponsesBlocEvent {}

class ResponsesBlocEvent_init extends ResponsesBlocEvent {}

class ResponsesBlocEvent_save_response extends ResponsesBlocEvent {
  final Response response;
  final List<ParameterModel> params;
  final HTTP_METHOD currentMethod;
  ResponsesBlocEvent_save_response({
    required this.response,
    required this.params,
    required this.currentMethod
  });
}

class ResponsesBlocEvent_delete_response extends ResponsesBlocEvent {
  final ResponseModel response;

  ResponsesBlocEvent_delete_response({required this.response});
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

    ///
    /// RESPONSE BLOC EVENT - SAVE
    ///
    on<ResponsesBlocEvent_save_response>((event, emit) async {
      try {
        final id = DateTime.now().microsecondsSinceEpoch;

        final ResponseModel responseModel = ResponseModel(
          id: id,
          requestId: '1',
          endpointUrl: event.response.realUri.toString(),
          statusCode: event.response.statusCode ?? 200,
          headersJson: event.response.headers.toString(),
          body: event.response.data,
          size: calculateTotalResponseSize(event.response),
          responseTimeMs: 424,
          cookies: event.response.headers['set-cookie'].toString(),
          parameters: convertListParamsToString(listParams: event.params),
          created: DateTime.now(),
          httpMethod: event.currentMethod
        );

        logger.i('SAVE RESPONSE : BODY ${event.response.data.toString()}');

        await responsesLocalStorageRepo.insertData(response: responseModel);
      } catch (e) {
        emit(ResponsesBlocState_error());
      } finally {
        add(ResponsesBlocEvent_init());
      }
    });

    on<ResponsesBlocEvent_delete_response>((event, emit) async {
      try {
        await responsesLocalStorageRepo.deleteData(response: event.response);
      } catch (e) {
        emit(ResponsesBlocState_error());
      } finally {
        add(ResponsesBlocEvent_init());
      }
    });
  }
}
