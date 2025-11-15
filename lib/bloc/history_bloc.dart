// ignore_for_file: camel_case_types

import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/core/utils/parameter_list_formatter.dart';
import 'package:api_client/core/utils/response_size_calculator.dart';
import 'package:api_client/data/model/parameter_model.dart';
import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/data/repository/local_storage_repository_res.dart';
import 'package:api_client/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

/// RESPONSES BLOC = USING FOR CONTROL SAVED RESPONSED

// ignore_for_file: dangling_library_doc_comments

///
/// RESPONSES BLOC EVENT
///
abstract class HistoryBlocEvent {}

class HistoryBlocEvent_init extends HistoryBlocEvent {}

class HistoryBlocEvent_save_response extends HistoryBlocEvent {
  final Response response;
  final List<ParameterModel> params;
  final HTTP_METHOD currentMethod;
  final int responseTime;
  HistoryBlocEvent_save_response({
    required this.response,
    required this.params,
    required this.currentMethod,
    required this.responseTime,
  });
}

class ResponsesBlocEvent_delete_response extends HistoryBlocEvent {
  final ResponseModel response;

  ResponsesBlocEvent_delete_response({required this.response});
}

///
/// RESPONSES BLOC STATE
///

abstract class HistoryBlocState {}

class HistoryBlocState_initial extends HistoryBlocState {}

class HistoryBlocState_loading extends HistoryBlocState {}

class HistoryBlocState_loaded extends HistoryBlocState {
  final List<ResponseModel> responses;

  HistoryBlocState_loaded({required this.responses});
}

class HistoryBlocState_error extends HistoryBlocState {}

///
/// RESPONSES BLOC
///

class HistoryBloc extends Bloc<HistoryBlocEvent, HistoryBlocState> {
  final LocalStorageRepositoryRes responsesLocalStorageRepo;
  HistoryBloc({required this.responsesLocalStorageRepo})
    : super(HistoryBlocState_initial()) {
    ///
    /// RESPONSE BLOC EVENT - INIT
    ///
    on<HistoryBlocEvent_init>((event, emit) async {
      try {
        final responseList = await responsesLocalStorageRepo.getAllResponse();
        emit(HistoryBlocState_loaded(responses: responseList));
      } catch (e) {
        emit(HistoryBlocState_error());
      }
    });

    ///
    /// RESPONSE BLOC EVENT - SAVE
    ///
    on<HistoryBlocEvent_save_response>((event, emit) async {
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
          httpMethod: event.currentMethod,
          responseTime: event.responseTime,
        );

        logger.i('SAVE RESPONSE : BODY ${event.response.data.toString()}');

        await responsesLocalStorageRepo.insertData(response: responseModel);
      } catch (e) {
        emit(HistoryBlocState_error());
      } finally {
        add(HistoryBlocEvent_init());
      }
    });

    on<ResponsesBlocEvent_delete_response>((event, emit) async {
      try {
        await responsesLocalStorageRepo.deleteData(response: event.response);
      } catch (e) {
        emit(HistoryBlocState_error());
      } finally {
        add(HistoryBlocEvent_init());
      }
    });
  }
}
