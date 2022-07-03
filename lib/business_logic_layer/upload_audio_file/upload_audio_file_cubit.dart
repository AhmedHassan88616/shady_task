import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/services/storage_sevice.dart';
import '../../shared/constants/constants.dart';

part 'upload_audio_file_state.dart';

class UploadAudioFileCubit extends Cubit<UploadAudioFileState> {
  UploadAudioFileCubit() : super(UploadAudioFileInitial());

  static UploadAudioFileCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  String? fileUrl;

  upload({required String filePath}) {
    emit(UploadAudioFileLoadingState());
    StorageService()
        .uploadFile(
      filePath: filePath,
      fileRef: 'shady_audios',
    )
        .then((value) {
      fileUrl = value;
      print('url : $fileUrl');
      showSuccessToast(successMessage: 'Success');
      emit(UploadAudioFileSuccessState());
    }).catchError((error) {
      showErrorToast(error: Exception('asd'));
      emit(UploadAudioFileErrorState(error: error));
    });
  }
}
