part of 'recorder_cubit.dart';

@immutable
abstract class RecorderState {}

class RecorderInitial extends RecorderState {}

class StopRecorderState extends RecorderState {}

class StartRecorderState extends RecorderState {}

class ResumeRecorderState extends RecorderState {}

class PauseRecorderState extends RecorderState {}

class DeleteRecorderState extends RecorderState {}

class TimerState extends RecorderState {}
