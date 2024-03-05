import 'package:flutter/material.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/clientDetails_screen/client_widgets/client_details_bar.dart';
import 'package:table_prototype/models/client_model.dart';

class ClientInformationsSide extends StatelessWidget {
  const ClientInformationsSide(
      {super.key, required this.client, required this.notifier});

  final ClientModel client;
  final ClientNotifier notifier;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClientDetailsBar(
        topText: 'name',
        txt: client.name,
        onchange: (val) {
          var newClient = client.copyWith(name: val).toJson();

          notifier.editClient(client.uid, newClient, context);
        },
      ),
      SizedBox(
        height: 20,
      ),
      ClientDetailsBar(
          onchange: (val) {
            var newClient = client.copyWith(familyName: val).toJson();

            notifier.editClient(client.uid, newClient, context);
          },
          topText: 'familyName',
          txt: client.familyName),
      SizedBox(
        height: 20,
      ),
      ClientDetailsBar(
        onchange: (val) {
          var newClient = client.copyWith(age: int.parse(val)).toJson();

          notifier.editClient(client.uid, newClient, context);
        },
        topText: 'age',
        txt: client.age.toString(),
      ),
      SizedBox(
        height: 20,
      ),
      ClientDetailsBar(
          onchange: (val) {
            var newClient = client.copyWith(phone: val).toJson();

            notifier.editClient(client.uid, newClient, context);
          },
          topText: 'phone',
          txt: client.phone),
      SizedBox(
        height: 20,
      ),
      ClientDetailsBar(
          onchange: (val) {
            var newClient = client.copyWith(ville: val).toJson();

            notifier.editClient(client.uid, newClient, context);
          },
          topText: 'ville',
          txt: client.ville),
      SizedBox(
        height: 20,
      ),
      ClientDetailsBar(
        onchange: (val) {
          var newClient = client.copyWith(lastVisit: val).toJson();

          notifier.editClient(client.uid, newClient, context);
        },
        topText: 'lastVisit',
        txt: client.lastVisit,
      ),
    ]);
  }
}
