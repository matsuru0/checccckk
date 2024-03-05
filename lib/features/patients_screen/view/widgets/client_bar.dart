import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/patients_screen/view/constants.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/bar_text.dart';
import 'package:table_prototype/core/common/table_button.dart';
import 'package:table_prototype/models/client_model.dart';

class Client_bar extends StatefulWidget {
  const Client_bar(
      {super.key,
      required this.currentClient,
      required this.index,
      required this.setIsOnTable});
  final int index;
  final ClientModel currentClient;
  final Function(String) setIsOnTable;
  @override
  State<Client_bar> createState() => _Client_barState();
}

class _Client_barState extends State<Client_bar> {
  bool editable = false;
  bool isGoingToDelete = false;
  bool isMouseIn = false;
  late ClientModel tempClientModel;

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size);
    return LayoutBuilder(builder: (context, constraints) {
      // print(constraints.maxWidth);
      return Consumer(
        builder: (_, WidgetRef ref, __) {
          var clientNotifier = ref.read(clientNotifierProvider().notifier);
          return MouseRegion(
            onEnter: (pointer) {
              setState(() {
                isMouseIn = true;
              });
            },
            onExit: (pointer) {
              setState(() {
                isMouseIn = false;
              });
            },
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                widget.setIsOnTable(widget.currentClient.uid);
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      widget.index % 2 != 0 ? Colors.white : Color(0xffE9E9E9),
                ),
                padding: const EdgeInsets.only(left: 35, right: 20),
                height: 50,
                child: Row(
                  children: [
                    /* table_text(widget.currentClient.familyName, width: 75),
                    table_text(widget.currentClient.name, width: 75),
                    SizedBox(
                      width: spacing_between_bar_info,
                    ),
                    table_text(widget.currentClient.age.toString()),
                    /*SizedBox(
                      width: spacing_between_bar_info,
                    ),*/
                    table_text(widget.currentClient.ville.toString()),
                    SizedBox(
                      width: spacing_between_bar_info,
                    ),
                    table_text(widget.currentClient.phone.toString()),
                    SizedBox(
                      width: spacing_between_bar_info,
                    ),
                    table_text(widget.currentClient.lastVisit.toString()),
                    SizedBox(
                      width: spacing_between_bar_info,
                    ),
                    table_text(widget.currentClient.lastVisit.toString(),
                        width: 130),
                    widget.currentClient.isInWaitingRoom
                        ? Icon(Icons.chair, size: 22)
                        : SizedBox(),
                    isMouseIn
                        ? TableButton(
                            onTap: () {
                              ClientModel newClient = widget.currentClient
                                  .copyWith(
                                      isInWaitingRoom: !widget
                                          .currentClient.isInWaitingRoom);
                              clientNotifier.editClient(
                                  widget.currentClient.uid,
                                  newClient.toJson(),
                                  context);
                            },
                            icon: !widget.currentClient.isInWaitingRoom
                                ? Icons.door_back_door
                                : Icons.exit_to_app)
                        : SizedBox(),*/

                    table_text(widget.currentClient.familyName, width: 75),
                    constraints.maxWidth > 900
                        ? table_text(widget.currentClient.age.toString())
                        : const SizedBox(),
                    constraints.maxWidth > 900
                        ? table_text(widget.currentClient.ville.toString())
                        : SizedBox(),
                    table_text(widget.currentClient.phone.toString()),
                    table_text(widget.currentClient.lastVisit.toString()),
                    constraints.maxWidth > 600
                        ? table_text(
                            widget.currentClient.appointement != null
                                ? DateFormat('yyyy-MM-dd').format(widget
                                    .currentClient.appointement!
                                    .toLocal())
                                : 'temp',
                            width: 130)
                        : const SizedBox(),
                    Container(
                      width: 50,
                      child: Row(
                        children: [
                          widget.currentClient.isInWaitingRoom
                              ? Icon(Icons.chair, size: 22)
                              : SizedBox(),
                          isMouseIn
                              ? TableButton(
                                  onTap: () {
                                    ClientModel newClient = widget.currentClient
                                        .copyWith(
                                            isInWaitingRoom: !widget
                                                .currentClient.isInWaitingRoom);
                                    clientNotifier.editClient(
                                        widget.currentClient.uid,
                                        newClient.toJson(),
                                        context);
                                  },
                                  icon: !widget.currentClient.isInWaitingRoom
                                      ? Icons.door_back_door
                                      : Icons.exit_to_app)
                              : SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Expanded table_text(txt, {double width = 150}) {
    return Expanded(
      flex: 1,
      child: Text(txt, style: TextStyle(fontSize: 12)),
    );
  }

  void _setClientOnWaitingRoom(clientNotifier) {
    ClientModel newClient = widget.currentClient
        .copyWith(isInWaitingRoom: !widget.currentClient.isInWaitingRoom);
    clientNotifier.editClient(
        widget.currentClient.uid, newClient.toJson(), context);
  }
}
