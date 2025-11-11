// ignore_for_file: dangling_library_doc_comments, camel_case_types

import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
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

class RequestBlocState_Success extends RequestBlocState {}

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
       // await Future.delayed(Duration(seconds: 2));
        await httpServiceRepository.makeGETrequest(request: event.requestModel);
      } catch (e) {
        emit(RequestBlocState_Error(error: e.toString()));
      } finally {
        emit(RequestBlocState_Initial());
      }
    });
  }
}
