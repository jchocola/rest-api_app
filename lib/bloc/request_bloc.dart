// ignore_for_file: dangling_library_doc_comments, camel_case_types

import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// REQUEST BLOC EVENT
///
///
abstract class RequestBlocEvent {}

class RequestBlocEvent_make_request extends RequestBlocEvent {
  final RequestModel requestModel;
  RequestBlocEvent_make_request({required this.requestModel});
}

///
/// REQUEST BLOC STATE
///
abstract class RequestBlocState {}

class RequestBlocState_Initial extends RequestBlocState {}

class RequestBlocState_Loading extends RequestBlocState {}

class RequestBlocState_Error extends RequestBlocState {
  final String error;
  RequestBlocState_Error({required this.error});
}

class RequestBlocState_Success extends RequestBlocState {
  final Response response;
  RequestBlocState_Success({required this.response});
}

///
/// REQUEST BLOC
///
class RequestBloc extends Bloc<RequestBlocEvent, RequestBlocState> {
  final HttpServiceRepository httpServiceRepository;
  RequestBloc({required this.httpServiceRepository})
    : super(RequestBlocState_Initial()) {
    ///
    /// REQUEST BLOC EVENT MAKE REQUEST
    ///
    on<RequestBlocEvent_make_request>((event, emit) async {
      emit(RequestBlocState_Loading());

      try {
        late Response response;

        switch (event.requestModel.httpMethod) {
          case HTTP_METHOD.GET:
            response = await httpServiceRepository.makeGETrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.POST:
            await httpServiceRepository.makePOSTrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.PUT:
            await httpServiceRepository.makePUTrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.PATCH:
            await httpServiceRepository.makePATCHrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.DELETE:
            await httpServiceRepository.makeDELETErequest(
              request: event.requestModel,
            );
          case HTTP_METHOD.OPTIONS:
            await httpServiceRepository.makeOPTIONSrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.HEAD:
            await httpServiceRepository.makeHEADrequest(
              request: event.requestModel,
            );
        }

        emit(RequestBlocState_Success(response: response));
      } catch (e) {
        emit(RequestBlocState_Error(error: e.toString()));
      } finally {
        emit(RequestBlocState_Initial());
      }
    });
  }
}
