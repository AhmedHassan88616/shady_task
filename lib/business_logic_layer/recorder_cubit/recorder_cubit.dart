import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'recorder_state.dart';

class RecorderCubit extends Cubit<RecorderState> {
  RecorderCubit() : super(RecorderInitial());

  static RecorderCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  String? path;
  bool isRecording = false;
  bool isPaused = false;
  int recordDuration = 0;
  Timer? timer;
  Record audioRecorder = Record();

  Future<void> start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }
        Directory tempDir = await getTemporaryDirectory();

        await audioRecorder.start(
            path: tempDir.path +
                'audio' +
                DateTime.now().microsecondsSinceEpoch.toString() +
                '.mp3');

        isRecording = await audioRecorder.isRecording();

        isRecording = isRecording;
        recordDuration = 0;

        emit(StartRecorderState());
        startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> stop() async {
    timer?.cancel();
    path = await audioRecorder.stop();
    // widget.onStop(path!);
    emit(StopRecorderState());
    delete();
  }

  Future<void> pause() async {
    timer?.cancel();
    await audioRecorder.pause();
    isPaused = true;
    emit(PauseRecorderState());
  }

  Future<void> resume() async {
    startTimer();
    await audioRecorder.resume();
    isPaused = false;
    emit(ResumeRecorderState());
  }

  void delete() {
    timer?.cancel();
    isRecording = false;
    isPaused = false;
    recordDuration = 0;
    audioRecorder = Record();
    emit(DeleteRecorderState());
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      emit(TimerState());
    });
  }
}
