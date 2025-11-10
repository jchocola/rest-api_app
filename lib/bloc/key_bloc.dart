// ignore_for_file: camel_case_types

import 'package:api_client/data/model/key_model.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:api_client/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///  KEY BLOC FOR CONTROLLING KEY STORAGE
///

///
/// EVENT
///
abstract class KeyBlocEvent {}

class KeyBlocEvent_loadKeys extends KeyBlocEvent {}

class KeyBlocEvent_saveNewKey extends KeyBlocEvent {
  final KeyModel newKey;
  KeyBlocEvent_saveNewKey({required this.newKey});
}

class KeyBlocEvent_deleteKey extends KeyBlocEvent {
  final KeyModel key;
  KeyBlocEvent_deleteKey({required this.key});
}

///
/// STATE
///

abstract class KeyBlocState {}

class KeyBlocInitial extends KeyBlocState {}

class KeyBlocLoading extends KeyBlocState {}

class KeyBlocLoaded extends KeyBlocState {
  final List<KeyModel> keys;
  KeyBlocLoaded({required this.keys});
}

class KeyBlocSuccess extends KeyBlocState {
  final String title;
  KeyBlocSuccess({required this.title});
}

class KeyBlocError extends KeyBlocState {
  final String eror;
  KeyBlocError({required this.eror});
}

///
/// KEY BLOC
///

class KeyBloc extends Bloc<KeyBlocEvent, KeyBlocState> {
  final SecureStorageRepository secureRepository;

  KeyBloc({required this.secureRepository}) : super(KeyBlocInitial()) {
    ///
    /// KEY BLOC EVENT _ LOAD KEYS
    ///
    on<KeyBlocEvent_loadKeys>((event, emit) async {
      try {
        emit(KeyBlocLoading());
        final keys = await secureRepository.getAllKeys();
        emit(KeyBlocLoaded(keys: keys));
      } catch (e) {
        emit(KeyBlocError(eror: e.toString()));
      }
    });

    ///
    /// KEY BLOC EVENT _ SAVE NEW KEY
    ///
    on<KeyBlocEvent_saveNewKey>((event, emit) async {
      try {
        emit(KeyBlocLoading());

        // save new key
        await secureRepository.createKey(newKey: event.newKey).then((value) {
          emit(KeyBlocSuccess(title: 'Created key'));
        });

        // reload key list
        add(KeyBlocEvent_loadKeys());
      } catch (e) {
        emit(KeyBlocError(eror: e.toString()));
        logger.e(e);
      }
    });

    ///
    /// KEY BLOC EVENT _ delete KEY
    ///
    on<KeyBlocEvent_deleteKey>((event, emit) async {
      try {
        emit(KeyBlocLoading());

        // save new key
        await secureRepository.deleteKey(key: event.key).then((value) {
          emit(KeyBlocSuccess(title: 'Deleted key')); 
        });

        // reload key list
        add(KeyBlocEvent_loadKeys());
      } catch (e) {
        emit(KeyBlocError(eror: e.toString()));
        logger.e(e);
      }
    });
  }
}
