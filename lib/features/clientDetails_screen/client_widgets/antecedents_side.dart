import 'package:flutter/material.dart';
import 'package:table_prototype/features/patients_screen/controller/antecedent_controller.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/clientDetails_screen/client_widgets/client_details_bar.dart';
import 'package:table_prototype/core/common/table_button.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/client_model.dart';

class AntecedentsSide extends StatelessWidget {
  const AntecedentsSide({
    super.key,
    required this.clientNotifier,
    required this.client,
    required this.antecedents,
  });

  final ClientNotifier clientNotifier;
  final List<AntecedentModel> antecedents;
  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 200,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: antecedents.length, //
                itemBuilder: (context, index) {
                  bool exists = client.antecedents
                      .any((ant) => ant.uid == antecedents[index].uid);
                  return !exists
                      ? ElevatedButton(
                          onPressed: () {
                            var newAnt = AntecedentModel(
                                history: [],
                                uid: antecedents[index].uid,
                                title: antecedents[index].title,
                                value: '');

                            if (!exists) {
                              List<AntecedentModel> newList = [
                                ...client.antecedents,
                                newAnt
                              ];
                              ClientModel newClient =
                                  client.copyWith(antecedents: newList);
                              clientNotifier.editClient(
                                  client.uid, newClient.toJson(), context);
                            } else {}
                          },
                          child: Text(antecedents[index].title))
                      : SizedBox();
                })),
        SizedBox(
          width: 500,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: client.antecedents.length,
            itemBuilder: (context, index) {
              AntecedentModel ant = client.antecedents[index];

              return ClientAntecedent(
                  index: index,
                  ant: ant,
                  client: client,
                  clientNotifier: clientNotifier);
            },
          ),
        ),
      ],
    );
  }
}

class ClientAntecedent extends StatefulWidget {
  const ClientAntecedent(
      {super.key,
      required this.ant,
      required this.client,
      required this.clientNotifier,
      required this.index});

  final AntecedentModel ant;
  final ClientModel client;
  final ClientNotifier clientNotifier;
  final int index;

  @override
  State<ClientAntecedent> createState() => _ClientAntecedentState();
}

class _ClientAntecedentState extends State<ClientAntecedent> {
  var showLog = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showLog ? Text('antec UI ${widget.ant.history}') : SizedBox(),
        Row(
          children: [
            ClientDetailsBar(
              onchange: (val) {
                AntecedentModel newAnt = widget.ant.copyWith(value: val);

                List<AntecedentModel> newList =
                    List.from(widget.client.antecedents);
                newList[widget.index] = newAnt;

                ClientModel newClient =
                    widget.client.copyWith(antecedents: newList);
                widget.clientNotifier
                    .editClient(widget.client.uid, newClient.toJson(), context);
              },
              topText: widget.ant.title,
              txt: widget.ant.value,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: TableButton(
                  onTap: () {
                    List<AntecedentModel> newList =
                        List.from(widget.client.antecedents);
                    newList.removeAt(widget.index);
                    ClientModel newClient =
                        widget.client.copyWith(antecedents: newList);

                    widget.clientNotifier.editClient(
                        widget.client.uid, newClient.toJson(), context);
                  },
                  icon: Icons.delete),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: TableButton(
                  onTap: () {
                    setState(() {
                      showLog = !showLog;
                    });
                  },
                  icon: Icons.history),
            )
          ],
        )
      ],
    );
  }
}
