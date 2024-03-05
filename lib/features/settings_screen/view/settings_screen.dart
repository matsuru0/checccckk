import 'package:flutter/material.dart';
import 'package:table_prototype/features/settings_screen/view/widgets/antecedents_list.dart';
import 'package:table_prototype/models/antecedent_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/features/patients_screen/controller/antecedent_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen(this.setSelectedIndex);
  final VoidCallback setSelectedIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final AsyncValue<List<AntecedentModel>> antecedents =
            ref.watch(antecedentNotifierProvider);
          AntecedentNotifier antecdenetNotifier = ref.read(antecedentNotifierProvider.notifier);
        return Scaffold(
          body: antecedents.when(
            data: (value) {
              return AntecedentList(value,setSelectedIndex,antecdenetNotifier);
            },
            error: (error, stack) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
