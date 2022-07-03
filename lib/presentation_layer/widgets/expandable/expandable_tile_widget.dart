import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/business_logic_layer/expandable_cubit/expandable_cubit.dart';

import '../../../business_logic_layer/localization_cubit/localization_cubit.dart';
import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';

class ExpandableTileWidget extends StatelessWidget {
  final String title;
  final ExpandableCubit controller;
  final List<Widget> children;

  const ExpandableTileWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    return BlocProvider(
      create: (context) => controller,
      child: BlocConsumer<ExpandableCubit, ExpandableState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16.0),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.changeExpansionPanelState();
                        },
                        icon: controller.icon,
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  constraints: controller.isExpanded
                      ? BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 100.0)
                      : const BoxConstraints(minHeight: 0.0, maxHeight: 0.0),
                  width: double.infinity,
                  duration: const Duration(milliseconds: 300),
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    children: children,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
