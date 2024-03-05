import 'package:flutter/material.dart';
import 'package:table_prototype/core/common/callToActionButton.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/patients_screen/view/constants.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/client_list.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/table_bar.dart';
import 'widgets/filter_by_dropdown.dart';
import 'widgets/search_bar.dart';

class ClientsTable extends StatelessWidget {
  const ClientsTable(
      this.clients, this.notifier, this.setIsOnTable, this.setSelectedIndex,
      {super.key});
  final List<ClientModel> clients;
  final ClientNotifier notifier;
  final Function(String) setIsOnTable;
  final VoidCallback setSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Search_bar('date'),
              const SizedBox(
                width: 10,
              ),
              FilterBy(notifier),
              //Filter_bar(),
              const Spacer(),
              CallToActionButton('Ajouter un client', Icons.group_add_rounded,
                  () {
                notifier.addClient(context);
              }),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  border: Constants.border,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Table_bar(notifier),
                    Expanded(
                      child: ClientList(
                        clients: clients,
                        setIsOnTable: setIsOnTable,
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }
}
