import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shady_task/data_layer/services/storage_sevice.dart';
import 'package:shady_task/shared/constants/constants.dart';

part 'get_file_state.dart';

class GetFileCubit extends Cubit<GetFileState> {
  GetFileCubit() : super(GetFileInitial());

  static GetFileCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  String? fileUrl;

  getImage() {
    fileUrl = null;
    selectAndPickImage().then((value) {
      if (value != null) {
        _uploadFile(fileRef: 'shady_images', value: value);
      } else {
        showErrorToast(error: Exception('asd'));
        emit(GetFileErrorState(error: Exception('asd')));
      }
    }).catchError((error) {
      emit(GetFileErrorState(error: error));
    });
  }

  getVideo() {
    fileUrl = null;

    selectAndPickVideo().then((value) {
      if (value != null) {
        _uploadFile(fileRef: 'shady_videos', value: value);
      } else {
        showErrorToast(error: Exception('asd'));
        emit(GetFileErrorState(error: Exception('asd')));
      }
    }).catchError((error) {
      emit(GetFileErrorState(error: error));
    });
  }

  getAudio() {
    // getAudioFromStorage().then((value) {
    //   bytes = value;
    //   showSuccessToast(successMessage: 'Success');
    //   emit(GetFileSuccessState());
    // }).catchError((error) {
    //   emit(GetFileErrorState(error: error));
    // });
  }

  _uploadFile({required String fileRef, required File value}) {
    showLoadingToast();
    emit(UploadFileLoadingState());
    StorageService()
        .uploadFile(
      filePath: value.path,
      fileRef: fileRef,
    )
        .then((value) {
      fileUrl = value;
      print('$value');
      showSuccessToast(successMessage: 'Success');
      emit(UploadFileSuccessState());
    }).catchError((error) {
      emit(UploadFileErrorState(error: error));
    });
  }
}
