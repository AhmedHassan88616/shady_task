import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/business_logic_layer/localization_cubit/localization_cubit.dart';
import 'package:shady_task/business_logic_layer/recorder_cubit/recorder_cubit.dart';
import 'package:shady_task/business_logic_layer/theme_cubit/theme_cubit.dart';
import 'package:shady_task/business_logic_layer/upload_audio_file/upload_audio_file_cubit.dart';
import 'package:shady_task/presentation_layer/screens/loading/loading_screen.dart';

class AudioRecorderScreen extends StatefulWidget {
  final void Function(String path) onUploadCompleted;

  const AudioRecorderScreen({
    Key? key,
    required this.onUploadCompleted,
  }) : super(key: key);

  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final RecorderCubit _recorderCubit = RecorderCubit();
  final UploadAudioFileCubit _uploadAudioFileCubit = UploadAudioFileCubit();

  @override
  void dispose() {
    _recorderCubit.timer?.cancel();
    _recorderCubit.audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>();
    context.watch<LocalizationCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _recorderCubit,
        ),
        BlocProvider(
          create: (context) => _uploadAudioFileCubit,
        ),
      ],
      child: BlocConsumer<UploadAudioFileCubit, UploadAudioFileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UploadAudioFileSuccessState &&
              _uploadAudioFileCubit.fileUrl != null) {
            widget.onUploadCompleted(_uploadAudioFileCubit.fileUrl!);
            Navigator.pop(context);
          }
        },
        builder: (context, uploadState) {
          return BlocConsumer<RecorderCubit, RecorderState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is StopRecorderState && _recorderCubit.path != null) {
                _uploadAudioFileCubit.upload(filePath: _recorderCubit.path!);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: uploadState is UploadAudioFileLoadingState
                    ? LoadingScreen()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildRecordRemoveControl(),
                              const SizedBox(width: 20),
                              _buildPauseResumeControl(),
                              const SizedBox(width: 20),
                              _buildText(),
                            ],
                          ),
                          // if (_amplitude != null) ...[
                          //   const SizedBox(height: 40),
                          //   Text('Current: ${_amplitude?.current ?? 0.0}'),
                          //   Text('Max: ${_amplitude?.max ?? 0.0}'),
                          // ],
                          const SizedBox(
                            height: 20.0,
                          ),
                          _buildRecordUploadControl(),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRecordRemoveControl() {
    if (!_recorderCubit.isRecording && !_recorderCubit.isPaused) {
      return Container();
    }
    late Icon icon;
    late Color color;

    icon = const Icon(Icons.delete, color: Colors.red, size: 30);
    color = Colors.red.withOpacity(0.1);

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _recorderCubit.delete();
          },
        ),
      ),
    );
  }

  Widget _buildRecordUploadControl() {
    if (_recorderCubit.isPaused) {
      late Color color;

      color = Colors.red.withOpacity(0.1);

      return Container(
        height: 40.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Material(
          color: color,
          child: InkWell(
            child: Center(
                child: Text(
              'Upload',
              style: TextStyle(
                color: Colors.red,
              ),
            )),
            onTap: () {
              _recorderCubit.stop();
            },
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildPauseResumeControl() {
    late Icon icon;
    late Color color;

    if (_recorderCubit.isRecording && !_recorderCubit.isPaused) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            if (!_recorderCubit.isRecording) {
              _recorderCubit.start();
            } else {
              _recorderCubit.isPaused
                  ? _recorderCubit.resume()
                  : _recorderCubit.pause();
            }
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_recorderCubit.isRecording || _recorderCubit.isPaused) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recorderCubit.recordDuration ~/ 60);
    final String seconds = _formatNumber(_recorderCubit.recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }
}
