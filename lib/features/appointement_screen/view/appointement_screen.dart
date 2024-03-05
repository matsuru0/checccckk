import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_prototype/core/common/page_header.dart';
import 'package:table_prototype/core/common/table_button.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/clientDetails_screen/client_details.dart';
import 'package:table_prototype/features/patients_screen/controller/antecedent_controller.dart';
import 'package:table_prototype/features/patients_screen/controller/treatement_controller.dart';
import 'package:table_prototype/features/patients_screen/view/patient_screen.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/filter_by_dropdown.dart';

import 'package:table_prototype/features/patients_screen/view/widgets/search_bar.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/treatement_model.dart';
import 'package:table_prototype/theme/pallete.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';

import 'package:table_prototype/models/client_model.dart';

class AppointementScreen extends StatefulWidget {
  const AppointementScreen(this.setSelectedIndex, {super.key});
  final Function(int) setSelectedIndex;

  @override
  State<AppointementScreen> createState() => _AppointementScreenState();
}

class _AppointementScreenState extends State<AppointementScreen> {
  var isOnPatient = false;
  Widget? page = Text("user not found");
  void setPage(Widget? p) {
    setState(() {
      page = p;

      if (page != null) {
        isOnPatient = true;
      } else {
        isOnPatient = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOnPatient && page != null) {
      return page!;
    } else {
      return Consumer(
        builder: (_, WidgetRef ref, __) {
          final AsyncValue<List<ClientModel>> clients =
              ref.watch(clientNotifierProvider(sort: 'appointements'));
          ClientNotifier clientNotifier =
              ref.read(clientNotifierProvider(sort: 'appointements').notifier);
          return Container(
            child: clients.when(
              data: (value) {
                //  print('value $value');
                return Content(
                  value,
                  clientNotifier,
                  setPage,
                  widget.setSelectedIndex,
                );
                // Your content for the 'data' case goes here
              },
              error: (error, stack) => Text(' antecedentsError: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          );
        },
      );
    }
  }

  LayoutBuilder Content(
      List<ClientModel> clients, clientNotifier, setPage, setSelectedIndex) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          PageHeader(
              txt: 'Appointement',
              onTap: () {
                //widget.setIsOnTable(widget.client.uid);
              }),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Search_bar('appointements'),
                const SizedBox(
                  width: 10,
                ),
                FilterBy(clientNotifier),

                // const Spacer(),
                /*CallToActionButton(
                    'Create appointement', Icons.group_add_rounded, () {
                  //notifier.addClient(context);
                }),*/
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
              flex: 2,
              child: LeftSideAppointement(
                  clients, setPage, setSelectedIndex, clientNotifier),
            ),
            if (constraints.maxWidth > 1000)
              SizedBox(
                width: 50,
              ),
            // if (constraints.maxWidth > 1000)
            Expanded(
              flex: 2,
              child: RightSideAppointement(clients),
            ),
          ]))
        ],
      );
    });
  }
}

class LeftSideAppointement extends StatefulWidget {
  const LeftSideAppointement(
    this.clients,
    this.setPage,
    this.setSelectedIndex,
    this.clientNotifier, {
    super.key,
  });
  final List<ClientModel> clients;
  final setPage;
  final ClientNotifier clientNotifier;
  final Function(int) setSelectedIndex;
  @override
  State<LeftSideAppointement> createState() => _LeftSideAppointementState();
}

class _LeftSideAppointementState extends State<LeftSideAppointement> {
  DateTime? selectedDate;

  Future _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        selectedDate = pickedDate;

        // selectedDate = pickedDate.toString(); // Update the selected date
      });
      return selectedDate;
      // callback(pickedDate);
      //
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Appointement overview',
                    style: TextStyle(
                        color: const Color.fromRGBO(30, 30, 30, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    double width = constraints.maxWidth * 0.5;
                    return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Constants.border,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(35.0),
                            itemCount: widget.clients.length,
                            itemBuilder: (BuildContext context, int index) {
                              ClientModel currentClient = widget.clients[index];

                              return Column(
                                children: [
                                  ClientAppointementBar(
                                      currentClient,
                                      widget.setPage,
                                      widget.setSelectedIndex,
                                      widget.clientNotifier),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              );
                            }));
                  }),
                )
              ]));
    });
  }
}

class ClientAppointementBar extends StatefulWidget {
  ClientAppointementBar(
    this.client,
    this.setPage,
    this.setSelectedIndex,
    this.clientNotifier, {
    super.key,
  });
  final ClientNotifier clientNotifier;
  final ClientModel client;
  var setPage;
  final Function(int) setSelectedIndex;

  @override
  State<ClientAppointementBar> createState() => _ClientAppointementBarState();
}

class _ClientAppointementBarState extends State<ClientAppointementBar> {
  String appointement = '';
  @override
  void initState() {
    super.initState();
    var today = DateTime.now();

    if (widget.client.appointement != null) {
      DateTime userAppo = widget.client.appointement!;
      if (today.day == userAppo.day &&
          today.month == userAppo.month &&
          today.year == userAppo.year) {
        appointement = 'Today ${DateFormat('hh:mm a').format(userAppo)}';
      } else if (today.day + 1 == userAppo.day &&
          today.month == userAppo.month &&
          today.year == userAppo.year) {
        appointement = 'Tommorow ${DateFormat('hh:mm a').format(userAppo)}';
      } else {
        appointement = DateFormat('yyyy-MM-dd hh:mm a').format(userAppo);
      }
    }
  }

  bool isMouseIn = false;
  @override
  Widget build(BuildContext context) {
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
          /* Widget p = PatientScreen(
            widget.setSelectedIndex,
            client: widget.client,
            isOnTable: false,
          );
          widget.setPage(p);*/
          Widget p;
          p = Consumer(
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
                    return antecedents.when(
                      data: (antecedents) {
                        return treatements.when(
                          data: (treatements) {
                            return ClientDetails(widget.client, (String t) {
                              widget.setSelectedIndex(1);
                              widget.setPage(null);
                            }, clientNotifier, antecedents, treatements);
                          },
                          error: (error, stack) =>
                              Text('treatements Error: $error'),
                          loading: () => SizedBox(),
                        );
                      },
                      //ClientDetails(client, setIsOnTable, clientNotifier, val),
                      error: (error, stack) =>
                          Text(' antecedentsError: $error'),
                      loading: () => const SizedBox(),
                    );
                  },
                  error: (error, stack) => Text('clients Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                ),
              );
            },
          );
          widget.setPage(p);
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            decoration: BoxDecoration(
                color: Pallete.inputFillColor,
                border: Constants.border,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text("${appointement}",
                    style: TextStyle(
                        color: Pallete.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                //Text('Sacnner IRM'),
                SizedBox(
                  height: 5,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.account_circle_rounded, size: 50),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.client.familyName} ${widget.client.name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text('Phone: ${widget.client.phone}'),
                      // Text('Derniér visite: 14 Janvier 2024')
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      children: [
                        widget.client.isInWaitingRoom && !isMouseIn
                            ? Container(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Pallete.lightBlueColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(Icons.chair,
                                    size: 20, color: Colors.white))
                            : SizedBox(),
                        isMouseIn
                            ? MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    ClientModel newClient = widget.client
                                        .copyWith(
                                            isInWaitingRoom:
                                                !widget.client.isInWaitingRoom);
                                    widget.clientNotifier.editClient(
                                        widget.client.uid,
                                        newClient.toJson(),
                                        context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Pallete.lightBlueColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                          !widget.client.isInWaitingRoom
                                              ? Icons.door_back_door
                                              : Icons.exit_to_app,
                                          size: 20,
                                          color: Colors.white)),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ])
              ],
            )),
      ),
    );
  }
}

class RightSideAppointement extends StatefulWidget {
  const RightSideAppointement(
    this.clients, {
    super.key,
  });
  final List<ClientModel> clients;

  @override
  State<RightSideAppointement> createState() => _RightSideAppointementState();
}

class _RightSideAppointementState extends State<RightSideAppointement> {
  /* ClientModel tempClient = ClientModel(
    name: 'John',
    familyName: 'Doe',
    age: 30,
    addressEmail: 'john.doe@example.com',
    address: '123 Main Street',
    assurance: 'Health Insurance Inc.',
    birthdayDate: DateTime(1992, 5, 15),
    appointement: DateTime(2024, 3, 10, 15, 30),
    uid: 'abc123',
    phone: '555-1234',
    ville: 'Cityville',
    isAman: true,
    lastVisit: '2024-02-28',
    isInWaitingRoom: false,
    antecedents: [],
  );*/
  List<Map<String, List<ClientModel>>> data = [
    {"6": []}, // 6 am
    {"7": []},
    {"8": []},
    {"9": []},
    {"10": []},
    {"11": []},
    {"12": []},
    {"13": []},
    {"14": []},
    {"15": []},
    {"16": []},
    {"17": []},
    {"18": []}, // 6 pm
    {"19": []}, // 7 pm
    {"20": []}, // 8 pm
    {"21": []}, // 9 pm
    {"22": []}, // 10 pm
    {"23": []}, // 11 pm
    {"0": []}, // 12 am (midnight)
    {"1": []}, // 1 am
    {"2": []}, // 2 am
    {"3": []}, // 3 am
    {"4": []}, // 4 am
    {"5": []}, // 5 am
    // 7 am
  ];
  @override
  void initState() {
    super.initState();

    List<ClientModel> todayClients = [];
    DateTime today = DateTime.now();
    widget.clients.forEach((client) {
      if (client.appointement != null) {
        if (client.appointement!.day == today.day) {
          var appointementHour = client.appointement!.hour;
          for (int i = 0; i < data.length; i++) {
            String hourKey = data[i].keys.first;
            if (int.parse(hourKey) == appointementHour) {
              // Add the client to the corresponding hour slot
              //  print(int.parse(hourKey));
              ////  print(appointementHour);
              //  print("--------");
              data[i][hourKey]!.add(client);

              break; // Stop searching once the client is added
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
// Page
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Today',
                    style: TextStyle(
                        color: const Color.fromRGBO(30, 30, 30, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    double width = constraints.maxWidth * 0.45;
                    return Container(
                        padding: EdgeInsets.only(top: 10, left: 4),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Constants.border,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var hour = data[index].keys.first;
                                  var checkDay = int.parse(hour);
                                  String dayPart = '';

                                  if (checkDay < 12) {
                                    // Morning
                                    dayPart = "AM";
                                  } else {
                                    // Evening
                                    dayPart = "PM";
                                  }
                                  var currentClients = data[index][hour];
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 43,
                                                child: Text(
                                                  '$hour${dayPart}',
                                                  style: TextStyle(
                                                      color: Color(0xff696766),
                                                      fontSize: 13),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 100,
                                              width:
                                                  1, // Width of the vertical divider
                                              color: Pallete.dividerColor,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      10), // Adjust margin as needed
                                            ),
                                            Container(
                                              width: constraints.maxWidth - 113,
                                              height: 44,
                                              child: ListView.builder(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      currentClients!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index2) {
                                                    var currentClient =
                                                        currentClients[index2];

                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Pallete
                                                            .lightBlueColor,
                                                      ),
                                                      child: Text(
                                                          '${currentClient.familyName} ${currentClient.name}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 1,
                                        thickness: 1,
                                        indent: 40,
                                        endIndent: 0,
                                        color: Pallete.dividerColor,
                                      ),
                                    ],
                                  );
                                })));
                  }),
                )
              ]));
    });
  }
}
