import 'package:flutter/material.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/client_bar.dart';

class ClientList extends StatelessWidget {
  const ClientList(
      {super.key, required this.clients, required this.setIsOnTable});
  final Function(String) setIsOnTable;
  final List<ClientModel> clients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: clients.length,
        itemBuilder: (BuildContext context, int index) {
          ClientModel currentClient = clients[index];

          return Client_bar(
              currentClient: currentClient,
              index: index,
              setIsOnTable: setIsOnTable);
        });
  }
}
