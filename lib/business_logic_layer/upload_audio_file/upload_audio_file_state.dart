part of 'upload_audio_file_cubit.dart';

@immutable
abstract class UploadAudioFileState {}

class UploadAudioFileInitial extends UploadAudioFileState {}

class UploadAudioFileLoadingState extends UploadAudioFileState {}

class UploadAudioFileSuccessState extends UploadAudioFileState {}

class UploadAudioFileErrorState extends UploadAudioFileState {
  final error;

  UploadAudioFileErrorState({
    required this.error,
  });
}
