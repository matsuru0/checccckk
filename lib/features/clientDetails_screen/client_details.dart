import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/clientDetails_screen/client_widgets/drop_down.dart';
import 'package:table_prototype/features/ordonnance_screen/view/ordonnance_screen.dart';

import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';

import 'package:intl/intl.dart';

import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/models/treatement_model.dart';
import 'package:table_prototype/theme/pallete.dart';

import '../../core/common/page_header.dart';

import 'client_widgets/logs_container.dart';
import 'client_widgets/sexe.dart';
import 'client_widgets/simple_button.dart';
import 'client_widgets/text_box_client.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails(this.client, this.setIsOnTable, this.clientNotifier,
      this.antecedents, this.treatement,
      {super.key});
  final ClientModel client;
  final Function(String) setIsOnTable;
  final ClientNotifier clientNotifier;
  final List<AntecedentModel> antecedents;
  final List<Treatement> treatement;
  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

const double customWidth = 350;
const defaultDecoration = const InputDecoration(
  border: InputBorder.none,
);

class _ClientDetailsState extends State<ClientDetails> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isOrdonnanceScreen = false;
  late int age;
  void shutOrdonnanceScreen() {
    setState(() {
      isOrdonnanceScreen = false;
    });
  }

  bool disabled = false;
  String unsavedConsultation = '';
  List<Treatement> oldSelectedItems = [];
  List<Treatement>? unsavedTreatments;
  void setUnsavedConsultation(String val) {
    setState(() {
      unsavedConsultation = val;
    });
  }

  void setTreatement(List<Treatement> t) {
    setState(() {
      unsavedTreatments = t;
    });
  }

  void setOldSelectedItems(List<Treatement> t) {
    setState(() {
      oldSelectedItems = t;
    });
  }

  void setIsDisabled() {
    setState(() {
      disabled = true;
    });
  }

  double? unsavedPrice;
  @override
  void initState() {
    age = widget.client.age;
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.client.uid;

    return isOrdonnanceScreen
        ? OrdonnanceScreen(widget.client, shutOrdonnanceScreen)
        : LayoutBuilder(builder: (context, constraints) {
//print(constraints.maxWidth);
            double shit = constraints.maxWidth;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PageHeader(
                    txt: 'Patient overview',
                    onTap: () {
                      widget.setIsOnTable(widget.client.uid);
                    }),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //  Text('test'),
                      Expanded(
                        flex: 2,
                        child: PatientOverview(
                            id, context, widget.setIsOnTable, disabled),
                      ),
                      if (constraints.maxWidth > 1000)
                        SizedBox(
                          width: 100,
                        ),
                      if (constraints.maxWidth > 1000)
                        Expanded(
                          flex: 1,
                          child: LogsContainer(
                              widget.client,
                              widget.clientNotifier,
                              widget.antecedents,
                              setOldSelectedItems,
                              setUnsavedConsultation,
                              setIsDisabled),
                        )
                    ],
                  ),
                )
              ],
            );
          });
  }

  LayoutBuilder PatientOverview(
      String id, BuildContext context, setIsOnTable, isDisabled) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(!isDisabled ? 'Patient details' : 'OLD PATIENT OVERVIEW',
                style: TextStyle(
                    color: !isDisabled
                        ? const Color.fromRGBO(30, 30, 30, 1)
                        : Pallete.redColor,
                    fontWeight: !isDisabled ? FontWeight.w500 : FontWeight.w700,
                    fontSize: 18)),
            SizedBox(
              height: 18,
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                double width = constraints.maxWidth * 0.45;
                return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Constants.border,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: CustomScrollView(
                          //padding: EdgeInsets.zero,
                          slivers: [
                            SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      TextBoxClient('Family name',
                                          widget.client.familyName, (val) {
                                        ClientModel newClient = widget.client
                                            .copyWith(familyName: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);
                                      }, customWidth: width),
                                      Spacer(),
                                      TextBoxClient(
                                          'First name', widget.client.name,
                                          (val) {
                                        ClientModel newClient =
                                            widget.client.copyWith(name: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);
                                      }, customWidth: width),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextBoxClient(
                                            'Phone number', widget.client.phone,
                                            (val) {
                                          ClientModel newClient = widget.client
                                              .copyWith(phone: val);
                                          widget.clientNotifier.editClient(
                                              id, newClient.toJson(), context);
                                        },
                                            customWidth: width -
                                                100), // 85 is the sexe width widget
                                        SizedBox(
                                          width: customWidth * 0.05,
                                        ),
                                        Sexe((val) {
                                          ClientModel newClient = widget.client
                                              .copyWith(isAman: val);
                                          widget.clientNotifier.editClient(
                                              id, newClient.toJson(), context);
                                        }, widget.client.isAman),
                                        Spacer(),
                                        TextBoxClient(
                                            'Date de naissancce',
                                            widget.client.birthdayDate != null
                                                ? DateFormat('yyyy-MM-dd')
                                                    .format(widget
                                                        .client.birthdayDate!
                                                        .toLocal())
                                                : 'Select a date',
                                            (val) {},
                                            customWidth: width - 24 - 70,
                                            icon: Icons.calendar_today,
                                            onTap: () async {
                                          DateTime? _selectedDate =
                                              await _showDatePicker();
                                          if (_selectedDate != null) {
                                            calculateAge(_selectedDate);
                                          }
                                        }),
                                        SizedBox(
                                          width: customWidth * 0.05,
                                        ),
                                        TextBoxClient(
                                          'Age',
                                          age.toString(),
                                          (val) {
                                            /*  ClientModel newClient =
                                            widget.client.copyWith(ville: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);*/
                                          },
                                          customWidth:
                                              100, /* icon: Icons.add_location_alt_sharp*/
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  Row(children: [
                                    TextBoxClient(
                                        'N assurance', widget.client.assurance,
                                        customWidth: width, (val) {
                                      ClientModel newClient = widget.client
                                          .copyWith(assurance: val);
                                      widget.clientNotifier.editClient(
                                          id, newClient.toJson(), context);
                                    }),
                                    Spacer(),
                                    TextBoxClient('Address email',
                                        widget.client.addressEmail,
                                        customWidth: width, (val) {
                                      ClientModel newClient = widget.client
                                          .copyWith(addressEmail: val);
                                      widget.clientNotifier.editClient(
                                          id, newClient.toJson(), context);
                                    }),
                                  ]),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  Row(
                                    children: [
                                      TextBoxClient(
                                          'Address', widget.client.address,
                                          (val) {
                                        ClientModel newClient = widget.client
                                            .copyWith(address: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);
                                      }, customWidth: width),
                                      Spacer(),
                                      TextBoxClient(
                                          'Prochaine rendez-vous',
                                          widget.client.appointement != null
                                              ? DateFormat('yyyy-MM-dd').format(
                                                  widget.client.appointement!
                                                      .toLocal())
                                              : 'Select a date',
                                          (val) {},
                                          customWidth: width - 24,
                                          icon: Icons.calendar_today,
                                          onTap: () async {
                                        DateTime? _selectedDate =
                                            await _showDatePicker(age: false);
                                        TimeOfDay? _selectedTime =
                                            await _showClockPicker();
                                        if (_selectedDate != null &&
                                            _selectedTime != null) {
                                          setNextAppointement(
                                              _selectedDate, _selectedTime);
                                        }
                                      }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBoxClient(
                                        'Consultation',
                                        unsavedConsultation

                                        /*  widget.client.consultations.isEmpty
                                              ? ''
                                              : widget
                                                  .client
                                                  .consultations[widget
                                                          .client
                                                          .consultations
                                                          .length -
                                                      1]
                                                  .value*/
                                        ,
                                        (val) {
                                          setState(() {
                                            unsavedConsultation = val;
                                          });
                                          /*  ClientModel newClient = widget.client
                                            .copyWith(consultations: [
                                          ...widget.client.consultations,
                                          newConsultation
                                        ]);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);*/
                                        },
                                        customWidth: width,
                                        maxLines: 30,
                                        isDisabled: isDisabled,
                                      ),
                                      Spacer(),
                                      TreatementDropDown(
                                        width,
                                        widget.treatement,
                                        setTreatement,
                                        oldSelectedItems: oldSelectedItems,
                                      ),
                                      /*text_box('Treatement', widget.client.name,
                                          (val) {},
                                          customWidth: width),*/
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          SimpleButton(onTap: () {
                                            setState(() {
                                              isOrdonnanceScreen = true;
                                            });
                                          },
                                              txt: "Ordonnance",
                                              Icons.medical_services_rounded,
                                              Pallete.blueColor),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SimpleButton(onTap: () {
                                            ClientModel newClient =
                                                widget.client.copyWith(
                                                    isInWaitingRoom: !widget
                                                        .client
                                                        .isInWaitingRoom);
                                            widget.clientNotifier.editClient(
                                                widget.client.uid,
                                                newClient.toJson(),
                                                context);
                                          },
                                              txt:
                                                  !widget.client.isInWaitingRoom
                                                      ? "Add"
                                                      : "Remove",
                                              !widget.client.isInWaitingRoom
                                                  ? Icons.chair
                                                  : Icons.door_back_door,
                                              Pallete.blueColor)
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SimpleButton(
                                            Icons.check_circle,
                                            Pallete.blueColor,
                                            onTap: () {
                                              /*      Consultation? unsavedConsultation ; 
  List<Treatement>? unsavedTreatments;
  double? unsavedPrice;*/

                                              Consultation newConsultation =
                                                  Consultation(
                                                      date: DateTime.now(),
                                                      value:
                                                          unsavedConsultation);

                                              List<Treatement>
                                                  newListTreatements =
                                                  unsavedTreatments != null
                                                      ? unsavedTreatments!
                                                          .map((item) =>
                                                              item.copyWith(
                                                                  date: DateTime
                                                                      .now()))
                                                          .toList()
                                                      : [];
                                              Visit newVisit = Visit(
                                                  consultation: newConsultation,
                                                  treatements:
                                                      newListTreatements,
                                                  date: DateTime.now());
                                              /* ClientModel newClient = widget
                                                  .client
                                                  .copyWith(
                                                      treatements:
                                                          newListTreatements !=
                                                                  null
                                                              ? [
                                                                  ...widget
                                                                      .client
                                                                      .treatements,
                                                                  ...newListTreatements
                                                                ]
                                                              : widget.client
                                                                  .treatements,
                                                      consultations: [
                                                    ...widget
                                                        .client.consultations,
                                                    newConsultation
                                                  ]);*/
                                              ClientModel newClient = widget
                                                  .client
                                                  .copyWith(visits: [
                                                ...widget.client.visits,
                                                newVisit
                                              ]);

                                              widget.clientNotifier.editClient(
                                                  id,
                                                  newClient.toJson(),
                                                  context);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SimpleButton(
                                              Icons.delete, Pallete.redColor,
                                              onTap: () {
                                            _dialogBuilder(context);
                                            /* widget.clientNotifier.deleteClient(
                                                widget.client.uid);
                                            widget.setIsOnTable('');*/
                                          })
                                        ],
                                      )
                                    ],
                                  )
                                ]))
                          ]),
                    ));
              }),
            )
          ],
        ),
      );
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm delete'),
          content: const Text(
            'Are you sure you want to delete this user',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                widget.clientNotifier.deleteClient(widget.client.uid);
                widget.setIsOnTable('');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _showDatePicker({bool age = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: age ? DateTime(2000) : DateTime.now(),
      lastDate: age ? DateTime.now() : DateTime(2101),
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

  Future _showClockPicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
      return selectedTime;
    }
    return null;
  }

  void setNextAppointement(DateTime _selectedDate, TimeOfDay _selectedTime) {
    DateTime combinedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    ClientModel newClient =
        widget.client.copyWith(appointement: combinedDateTime);
    widget.clientNotifier
        .editClient(widget.client.uid, newClient.toJson(), context);
  }

  void calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    setState(() {
      this.age = age;
      ClientModel newClient =
          widget.client.copyWith(age: age, birthdayDate: selectedDate);
      widget.clientNotifier
          .editClient(widget.client.uid, newClient.toJson(), context);
    });
  }
}
