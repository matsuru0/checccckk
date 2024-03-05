import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/features/patients_screen/controller/antecedent_controller.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/clientDetails_screen/client_details.dart';
import 'package:table_prototype/features/patients_screen/controller/treatement_controller.dart';
import 'package:table_prototype/features/patients_screen/view/clients_table.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/models/treatement_model.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen(
    this.setSelectedIndex,
  );
  final Function(int) setSelectedIndex;

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  bool isOnTable = true;
  late String onTapClient = '';
  late ClientModel? client;
  void setIsOnTable(String uid) {
    setState(() {
      if (uid == '') {
        isOnTable = true;
        widget.setSelectedIndex(0);
      } else {
        isOnTable = !isOnTable;
        if (!isOnTable && uid != '') {
          onTapClient = uid;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final AsyncValue<List<ClientModel>> clients =
            ref.watch(clientNotifierProvider());

        ClientNotifier clientNotifier =
            ref.read(clientNotifierProvider().notifier);
        final AsyncValue<List<AntecedentModel>> antecedents =
            ref.watch(antecedentNotifierProvider);

        final AsyncValue<List<Treatement>> treatements =
            ref.watch(treatementNotifierProvider);
        return Container(
          child: clients.when(
            data: (value) {
              if (isOnTable) {
                return ClientsTable(value, clientNotifier, setIsOnTable, () {
                  widget.setSelectedIndex(1);
                });
              } else {
                return antecedents.when(
                  data: (antecedents) {
                    return treatements.when(
                      data: (treatements) {
                        return ClientDetails(
                            value.firstWhere(
                                (element) => element.uid == onTapClient),
                            setIsOnTable,
                            clientNotifier,
                            antecedents,
                            treatements);
                      },
                      error: (error, stack) =>
                          Text('treatements Error: $error'),
                      loading: () => SizedBox(),
                    );
                  },
                  //ClientDetails(client, setIsOnTable, clientNotifier, val),
                  error: (error, stack) => Text(' antecedentsError: $error'),
                  loading: () => const SizedBox(),
                );
              }
            },
            error: (error, stack) => Text('clients Error: $error'),
            loading: () => const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  /*Widget buildClientDetailsWidget(antecedents, treatements, clientNotifier) {
    return antecedents.when(
      data: (antecedents) {
        return treatements.when(
          data: (treatements) {
            return ClientDetails(
              widget.client!,
              setIsOnTable,
              clientNotifier,
              antecedents,
              treatements,
            );
          },
          error: (error, stack) => Text('treatements Error: $error'),
          loading: () => const CircularProgressIndicator(),
        );
      },
      error: (error, stack) => Text(' antecedentsError: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }*/
}
