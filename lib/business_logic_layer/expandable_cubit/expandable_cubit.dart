import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'expandable_state.dart';

class ExpandableCubit extends Cubit<ExpandableState> {
  ExpandableCubit() : super(ExpandableInitial());

  static ExpandableCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  bool isExpanded = false;
  Icon icon = const Icon(
    Icons.expand_more,
    color: Colors.white,
    size: 30.0,
  );

  void changeExpansionPanelState() {
    isExpanded = !isExpanded;
    if (isExpanded) {
      icon = const Icon(
        Icons.expand_less,
        color: Colors.white,
        size: 30.0,
      );
    } else {
      icon = const Icon(
        Icons.expand_more,
        color: Colors.white,
        size: 30.0,
      );
    }
    emit(ChangeExpandableState());
  }
}
