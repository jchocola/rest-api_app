// ignore_for_file: dangling_library_doc_comments, camel_case_types

import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:api_client/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
  final int responseTime; // in millisec
  RequestBlocState_Success({
    required this.response,
    required this.responseTime,
  });
}

///
/// REQUEST BLOC
///
class RequestBloc extends Bloc<RequestBlocEvent, RequestBlocState> {
  final HttpServiceRepository httpServiceRepository;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  RequestBloc({required this.httpServiceRepository})
    : super(RequestBlocState_Initial()) {
    ///
    /// REQUEST BLOC EVENT MAKE REQUEST
    ///
    on<RequestBlocEvent_make_request>((event, emit) async {
      emit(RequestBlocState_Loading());

      try {
        // reset timer
        _stopWatchTimer.onResetTimer() ;

        // Start timer.
        _stopWatchTimer.onStartTimer();

        late Response response;

        switch (event.requestModel.httpMethod) {
          case HTTP_METHOD.GET:
            response = await httpServiceRepository.makeGETrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.POST:
            response = await httpServiceRepository.makePOSTrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.PUT:
            response = await httpServiceRepository.makePUTrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.PATCH:
            response = await httpServiceRepository.makePATCHrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.DELETE:
            response = await httpServiceRepository.makeDELETErequest(
              request: event.requestModel,
            );
          case HTTP_METHOD.OPTIONS:
            response = await httpServiceRepository.makeOPTIONSrequest(
              request: event.requestModel,
            );

          case HTTP_METHOD.HEAD:
            response = await httpServiceRepository.makeHEADrequest(
              request: event.requestModel,
            );
        }
        // Stop timer.
        _stopWatchTimer.onStopTimer();

        logger.i(_stopWatchTimer.rawTime.value.toString());

        emit(
          RequestBlocState_Success(
            response: response,
            responseTime: _stopWatchTimer.rawTime.value,
          ),
        );
      } catch (e) {
        emit(RequestBlocState_Error(error: e.toString()));
      } finally {
        emit(RequestBlocState_Initial());
      }
    });
  }
}
