import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/clientDetails_screen/client_widgets/antecedents_drop_down.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/bar_text.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/models/treatement_model.dart';
import 'package:table_prototype/theme/pallete.dart';
import 'package:intl/intl.dart';

class LogsContainer extends StatelessWidget {
  const LogsContainer(
    this.client,
    this.clientNotifier,
    this.antecedents,
    this.setTreatement,
    this.setUnsavedConsultation,
    this.setIsDisabled, {
    super.key,
  });
  final VoidCallback setIsDisabled;
  final Function(String) setUnsavedConsultation;
  final Function(List<Treatement> t) setTreatement;
  final ClientModel client;
  final ClientNotifier clientNotifier;
  final List<AntecedentModel> antecedents;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print("max height ${constraints.maxHeight}");
      var width = constraints.maxWidth;
      String id = client.uid;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Logs',
              style: TextStyle(
                  color: Pallete.headersColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18)),
          SizedBox(
            height: 18,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Constants.border,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dernier visites',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff433B35))),

                            SizedBox(height: 13),
                            SizedBox(
                              height: 90,
                              width: width,
                              child: ListView.builder(
                                  itemCount: client.visits.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Visit currentVisit = client.visits[index];

                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setIsDisabled();
                                          setTreatement(
                                              currentVisit.treatements);
                                          setUnsavedConsultation(
                                              currentVisit.consultation.value ??
                                                  '');
                                        },
                                        child: VisitContainer(currentVisit),
                                      ),
                                    );
                                  }),
                            ),
                            /*     VisitContainer(),
                            SizedBox(height: 10),
                            if (constraints.maxHeight > 500) VisitContainer(),*/
                            //SizedBox(height: 10),
                            // VisitContainer(),
                            if (constraints.maxHeight > 500)
                              SizedBox(
                                height: 35,
                              ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                              color: Pallete.dividerColor,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(children: [
                              Text('Les antécedents',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff433B35))),
                              Spacer(),
                              AntecedentDropDown(
                                  200, antecedents, clientNotifier, client)
                            ]),

                            SizedBox(height: 13),

                            /*SizedBox(
                                width: 200,
                                height: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: antecedents.length, //
                                    itemBuilder: (context, index) {
                                      bool exists = client.antecedents.any(
                                          (ant) =>
                                              ant.uid ==
                                              antecedents[index].uid);
                                      return !exists
                                          ? ElevatedButton(
                                              onPressed: () {
                                                var newAnt = AntecedentModel(
                                                    history: [],
                                                    uid: antecedents[index].uid,
                                                    title: antecedents[index]
                                                        .title,
                                                    value: '');
                                            
                                                if (!exists) {
                                                  List<AntecedentModel>
                                                      newList = [
                                                    ...client.antecedents,
                                                    newAnt
                                                  ];
                                                  ClientModel newClient =
                                                      client.copyWith(
                                                          antecedents: newList);
                                                  clientNotifier.editClient(
                                                      client.uid,
                                                      newClient.toJson(),
                                                      context);
                                                } else {}
                                              },
                                              child: Text(
                                                  antecedents[index].title))
                                          : SizedBox();
                                    })),*/
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: client.antecedents.length,
                                  itemBuilder: (context, index) {
                                    AntecedentModel ant =
                                        client.antecedents[index];

                                    return ClientAntecedent(
                                        index: index,
                                        ant: ant,
                                        client: client,
                                        clientNotifier: clientNotifier,
                                        width: width);
                                  },
                                ),
                              ),
                            ),
                          ]),
                    )
                  ])),
            ),
          ),
        ],
      );
    });
  }
}

class VisitContainer extends StatefulWidget {
  const VisitContainer(
    this.visit, {
    super.key,
  });
  final Visit visit;

  @override
  State<VisitContainer> createState() => _VisitContainerState();
}

class _VisitContainerState extends State<VisitContainer> {
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = _formatDate(widget.visit.date);
  }

  String _formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMMM yyyy, dd hh:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      height: 40,
      decoration: BoxDecoration(
          color: Pallete.inputFillColor,
          border: Constants.border,
          borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 7.0, right: 12.0, top: 7, bottom: 7),
        child: Row(
          children: [
            Text(formattedDate,
                style: TextStyle(fontSize: 12, color: Colors.black)),
            //Spacer(),
            //Icon(Icons.chair, size: 22)
          ],
        ),
      ),
    );
  }
}

class ClientAntecedent extends StatefulWidget {
  const ClientAntecedent(
      {super.key,
      required this.ant,
      required this.client,
      required this.clientNotifier,
      required this.index,
      required this.width});
  final double width;
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextBoxClientModedForAnt(widget.ant.title, widget.ant.value,
          customWidth: widget.width, (val) {
        AntecedentModel newAnt = widget.ant.copyWith(value: val);

        List<AntecedentModel> newList = List.from(widget.client.antecedents);
        newList[widget.index] = newAnt;

        ClientModel newClient = widget.client.copyWith(antecedents: newList);
        widget.clientNotifier
            .editClient(widget.client.uid, newClient.toJson(), context);
      }, () {
        print("yo");
        List<AntecedentModel> newList = List.from(widget.client.antecedents);
        newList.removeAt(widget.index);
        ClientModel newClient = widget.client.copyWith(antecedents: newList);

        widget.clientNotifier
            .editClient(widget.client.uid, newClient.toJson(), context);
      }),
    );
  }
}
/*   MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton(
                  onPressed: () {
                    List<AntecedentModel> newList =
                        List.from(widget.client.antecedents);
                    newList.removeAt(widget.index);
                    ClientModel newClient =
                        widget.client.copyWith(antecedents: newList);

                    widget.clientNotifier.editClient(
                        widget.client.uid, newClient.toJson(), context);
                  },
                  child: const Icon(Icons.delete) /*icon: Icons.delete*/),
            ),*/
/*MouseRegion(
              cursor: SystemMouseCursors.click,
              child: simple_buto(
                  onTap: () {
                    setState(() {
                      showLog = !showLog;
                    });
                  },
                  icon: Icons.history),
            )*/

class TextBoxClientModedForAnt extends StatefulWidget {
  final String topTxt;
  final String txt;
  final Function(String) onChange;
  final double customWidth;
  final InputDecoration? decoration1; // Make it nullable
  final icon;
  final VoidCallback? onTap;
  final int maxLines;
  final bool instantChange;
  final VoidCallback onDelete;
  const TextBoxClientModedForAnt(
    this.topTxt,
    this.txt,
    this.onChange,
    this.onDelete, {
    required this.customWidth,
    this.decoration1, // Make it nullable
    this.icon,
    this.onTap,
    this.maxLines = 1,
    this.instantChange = false,
  });

  @override
  State<TextBoxClientModedForAnt> createState() =>
      _TextBoxClientModedForAntState();
}

class _TextBoxClientModedForAntState extends State<TextBoxClientModedForAnt> {
  bool isMouseIn = false;
  @override
  Widget build(BuildContext context) {
    var decoration = widget.decoration1 ?? Constants.decoration;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.topTxt,
                  style: const TextStyle(
                      color: Color(0xff433B35),
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              Spacer(),
              Icon(Icons.history, size: 22, color: Colors.transparent),
              if (isMouseIn)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.history,
                        size: 22, color: const Color.fromARGB(255, 68, 68, 68)),
                  ),
                ),
              if (isMouseIn)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      widget.onDelete();
                    },
                    child: Icon(Icons.delete,
                        size: 22, color: const Color.fromARGB(255, 68, 68, 68)),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: widget.maxLines == 1 ? 40 : 120,
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Pallete.inputFillColor,
                border: Constants.border,
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bar_text(widget.txt, widget.onChange,
                    decoration: decoration ?? Constants.decoration,
                    customWidth: widget.customWidth - 60,
                    icon: widget.icon,
                    maxlines: widget.maxLines,
                    instantChange: widget.instantChange),
                widget.icon != null
                    ? MouseRegion(
                        cursor: widget.onTap != null
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.alias,
                        child: GestureDetector(
                            onTap: widget.onTap ?? () {},
                            child: Icon(widget.icon)))
                    : SizedBox()
                //Icon(Icons.cabin)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
