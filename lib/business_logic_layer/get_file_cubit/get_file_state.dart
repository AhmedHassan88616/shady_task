part of 'get_file_cubit.dart';

@immutable
abstract class GetFileState {}

class GetFileInitial extends GetFileState {}

class GetFileSuccessState extends GetFileState {}

class GetFileErrorState extends GetFileState {
  final error;

  GetFileErrorState({
    required this.error,
  });
}

class UploadFileLoadingState extends GetFileState {}

class UploadFileSuccessState extends GetFileState {}

class UploadFileErrorState extends GetFileState {
  final error;

  UploadFileErrorState({
    required this.error,
  });
}
