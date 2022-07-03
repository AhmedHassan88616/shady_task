part of 'radio_cubit.dart';

@immutable
abstract class RadioState {}

class RadioInitial extends RadioState {}

class ChangeRadioValueState extends RadioState {}
