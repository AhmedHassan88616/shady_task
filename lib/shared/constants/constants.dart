import 'dart:io';
import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';

const remoteBaseURL = 'https://Martizoom.com/api/';
const remoteStorageBaseURL = 'http://new.marwaradwan.co/storage/app/public/';

const localBaseURL = 'https://10.0.2.2/HRApp/api/';
const localStorageBaseURL = 'https://10.0.2.2/HRApp/storage/app/public/';

const baseURL = remoteBaseURL;
const storageBaseURL = remoteStorageBaseURL;
const isDarkKey = 'isDark';
AppLocalizations? appLocalization;

bool isLoggedIn = false;
bool isTabletDevice = false;
String viewType = '3d';
const viewTypeKey = 'view_type';
const langCodeKey = 'lang';
const countryIdKey = 'country';

bool isWhiteSpacesWord(String value) {
  if (value.isEmpty) return false;
  value = value.trim();
  debugPrint('value: ${value.length}');
  return value.isEmpty;
}

navigateTo({
  required context,
  required Widget screen,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}

navigateAndFinishTo({
  required context,
  required Widget screen,
  Function? then,
}) {
  Navigator.of(context)
      .pushReplacement(
        MaterialPageRoute(
          builder: (_) => screen,
        ),
      )
      .then((value) => then);
}

showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 18.0);
}

chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.FAILED:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.amber;
  }
}

// Toasts enum
enum ToastStates { SUCCESS, FAILED, WARNING }

getErrorMessage(error) {
  return 'There is an error';
}

showErrorToast({required error}) {
  showToast(message: getErrorMessage(error), state: ToastStates.FAILED);
}

showSuccessToast({required String successMessage}) {
  showToast(message: successMessage, state: ToastStates.SUCCESS);
}

showLoadingToast() {
  showToast(message: 'loading', state: ToastStates.WARNING);
}

DateTime getParsedDateTime(String? formattedString) {
  try {
    return intl.DateFormat('yyyy/MM/dd').parse(formattedString ?? '');
  } catch (e) {
    debugPrint('getParsedDateTime: $e');
  }
  return DateTime.now();
}

String convertDateTimeToString(DateTime date) {
  intl.DateFormat dateFormat = intl.DateFormat("yyyy/MM/dd");
  try {
    return dateFormat.format(date);
  } catch (e) {
    debugPrint('convertDateTimeToString: $e');
  }
  return '';
}

void showNetworkImageDialog(context,
    {required String imageTitle, required String imageURL}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SimpleDialog(
          title: Center(child: Text(imageTitle)),
          children: [
            Image.network(
              '$storageBaseURL/$imageURL',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Container(
                height: 100.0,
                width: 100.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    },
  );
}

bool isPortrait() {
  return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
          .orientation ==
      Orientation.portrait;
}

setWidthValue({required double portraitValue, required double landscapeValue}) {
  if (isPortrait()) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .width *
        portraitValue;
  } else {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .width *
        landscapeValue;
  }
}

setHeightValue(
    {required double portraitValue, required double landscapeValue}) {
  if (isPortrait()) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .height *
        portraitValue;
  } else {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .height *
        landscapeValue;
  }
}

const List<String> idTypes = ['Passport', 'National ID'];
const List<String> cities = ['Cairo', 'Sohag', 'Giza'];
const List<String> regions = ['nasr city', 'shubra', 'el marg'];
const List<String> medicalSpecialties = [
  'Allergy and immunology',
  'Anesthesiology',
  'Dermatology',
  'Diagnostic radiology',
  'Emergency medicine',
  'Family medicine',
  'Internal medicine',
  'Medical genetics',
  'Neurology',
];
const List<String> scientificDegrees = [
  'Bachelor',
];

Future<File?> selectAndPickImage() async {
  final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (xFile != null) {
    // compress image
    File file = File(xFile.path);
    return file;
  }
  return null;
}

Future<File?> selectAndPickVideo() async {
  final xFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

  if (xFile != null) {
    // compress image
    File file = File(xFile.path);
    return file;
  }
  return null;
}

// Future<Uint8List?> getAudioFromStorage() async {
//   const allowedExtensions = [
//     'mp3',
//   ];
//
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: allowedExtensions,
//   );
//   File? file;
//   if (result != null) {
//     file = File(result.files.single.path ?? '');
//     debugPrint('file path: ${file.path}');
//     return file.readAsBytesSync();
//   }
//   return null;
// }

Future<File> writeToFile(
    {required Uint8List data,
    required String fileName,
    required String extension}) async {
  final buffer = data.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = tempPath +
      '/$fileName.$extension'; // file_01.tmp is dump file, can be anything
  return File(filePath)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
