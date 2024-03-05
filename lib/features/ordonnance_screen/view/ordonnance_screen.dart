import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_prototype/core/common/callToActionButton.dart';
import 'package:table_prototype/core/common/page_header.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/clientDetails_screen/client_widgets/simple_button.dart';
import 'package:table_prototype/features/clientDetails_screen/client_widgets/text_box_client.dart';
import 'package:table_prototype/features/ordonnance_screen/view/widgets/drop_down_templates.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/theme/pallete.dart';

class OrdonnanceScreen extends StatefulWidget {
  const OrdonnanceScreen(this.client, this.shutOrdonnanceScreen);
  final ClientModel? client;
  final VoidCallback? shutOrdonnanceScreen;

  @override
  State<OrdonnanceScreen> createState() => _OrdonnanceScreenState();
}

class _OrdonnanceScreenState extends State<OrdonnanceScreen> {
  Map<String, String> ordonnanceDetails = {
    "familyName": "",
    "name": "",
    "ordonnance": "",
    "age": "",
    "date": ""
  };
  void updateOrdonnanceDetails(
      {String? familyName,
      String? name,
      String? ordonnance,
      String? age,
      String? date}) {
    setState(() {
      ordonnanceDetails = {
        "familyName": familyName ?? ordonnanceDetails['familyName'] ?? "",
        "name": name ?? ordonnanceDetails['name'] ?? "",
        "ordonnance": ordonnance ?? ordonnanceDetails['ordonnance'] ?? "",
        "age": age ?? ordonnanceDetails['age'] ?? "",
        "date": date ?? ordonnanceDetails['date'] ?? "",
      };
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      updateOrdonnanceDetails(
          familyName: widget.client!.familyName,
          name: widget.client!.name,
          age: widget.client!.age.toString(),
          date: DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          PageHeader(
              txt: 'Ordonnace overview',
              onTap: () {
                if (widget.shutOrdonnanceScreen != null) {
                  widget.shutOrdonnanceScreen!();
                }

                //widget.setIsOnTable(widget.client.uid);
              }),
          Expanded(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
              flex: 2,
              child: LeftSideOrdonnance(
                  updateOrdonnanceDetails, ordonnanceDetails),
            ),
            if (constraints.maxWidth > 1000)
              SizedBox(
                width: 100,
              ),
            if (constraints.maxWidth > 1000)
              Expanded(
                flex: 2,
                child: RightSideOrdonnance(ordonnanceDetails),
              ),
          ]))
        ],
      );
    });
  }
}

var pdfBytes;

class LeftSideOrdonnance extends StatefulWidget {
  const LeftSideOrdonnance(
    this.updateOrdonnanceDetails,
    this.ordonnanceDetails, {
    super.key,
  });

  final Map<String, String> ordonnanceDetails;
  final Function(
      {String? familyName,
      String? ordonnance,
      String? name,
      String? age,
      String? date}) updateOrdonnanceDetails;

  @override
  State<LeftSideOrdonnance> createState() => _LeftSideOrdonnanceState();
}

class _LeftSideOrdonnanceState extends State<LeftSideOrdonnance> {
  DateTime? selectedDate;
  String currentTemplate = 'default template';
  List<Map<String, String>> ordonnancesTemplates = [
    {"default": "default"},
    {"Template 1": "YOOO I AM TEPLATE 1"},
    {"Template 2": "YOOO I AM TEPLATE 2"},
    {"Template 3": "YOOO I AM TEPLATE 3"}
  ];
  void setCurrentTemplate(int index) {
    setState(() {
      currentTemplate = ordonnancesTemplates[index].values.first;
      widget.updateOrdonnanceDetails(ordonnance: currentTemplate);
    });
  }

  late List<String> templateNames;
  @override
  void initState() {
    super.initState();
    templateNames = ordonnancesTemplates.map((map) => map.keys.first).toList();
  }

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
                Text('Ordonnance',
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
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: CustomScrollView(slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(children: [
                                Row(
                                  children: [
                                    TextBoxClient(
                                      'Family name',
                                      widget.ordonnanceDetails['familyName'] ??
                                          '',
                                      (val) {
                                        widget.updateOrdonnanceDetails(
                                            familyName: val);
                                        /*ClientModel newClient =
                                            widget.client.copyWith(name: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);*/
                                      },
                                      customWidth: width,
                                      instantChange: true,
                                    ),
                                    Spacer(),
                                    TextBoxClient(
                                      'First name',
                                      widget.ordonnanceDetails['name'] ?? '',
                                      (val) {
                                        widget.updateOrdonnanceDetails(
                                            name: val);
                                        /*ClientModel newClient =
                                            widget.client.copyWith(name: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);*/
                                      },
                                      customWidth: width,
                                      instantChange: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 23,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TemplatesDropDown(width, templateNames,
                                        setCurrentTemplate),
                                    Spacer(),
                                    TextBoxClient(
                                        'Today date',
                                        /*  widget.client.birthdayDate != null
                                            ? DateFormat('yyyy-MM-dd').format(
                                                widget.client.birthdayDate!
                                                    .toLocal())
                                            :*/
                                        widget.ordonnanceDetails['date'] ??
                                            'select a date',
                                        (val) {},
                                        customWidth: width - 24 - 70,
                                        icon: Icons.calendar_today,
                                        onTap: () async {
                                      DateTime? _selectedDate =
                                          await _showDatePicker();
                                      if (_selectedDate != null) {
                                        widget.updateOrdonnanceDetails(
                                            date: DateFormat('yyyy-MM-dd')
                                                .format(
                                                    selectedDate!.toLocal()));
                                      }
                                    }),

                                    /*  SizedBox(
                                      width: customWidth * 0.05,
                                    ),*/
                                    SizedBox(
                                      width: 350 * 0.05,
                                    ),
                                    TextBoxClient(
                                      'Age',
                                      widget.ordonnanceDetails['age'] ?? '',
                                      (val) {
                                        widget.updateOrdonnanceDetails(
                                            age: val);
                                        /*  ClientModel newClient =
                                            widget.client.copyWith(ville: val);
                                        widget.clientNotifier.editClient(
                                            id, newClient.toJson(), context);*/
                                      },
                                      customWidth: 100,
                                      instantChange:
                                          true, /* icon: Icons.add_location_alt_sharp*/
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 23,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextBoxClient(
                                        'Ordonnance',
                                        widget.ordonnanceDetails[
                                                'ordonnance'] ??
                                            '',
                                        (val) {
                                          widget.updateOrdonnanceDetails(
                                              ordonnance: val);
                                        },
                                        customWidth: constraints.maxWidth - 30,
                                        maxLines: 30,
                                        instantChange: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 23,
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SimpleButton(onTap: () {
                                      Printing.directPrintPdf(
                                          format: PdfPageFormat.a5,
                                          name: "siht",
                                          printer: Printer(
                                              url: "Microsoft Print To PDF"),
                                          onLayout:
                                              (PdfPageFormat format) async =>
                                                  pdfBytes);
                                    },
                                        txt: "Save as Pdf",
                                        Icons.save_rounded,
                                        Pallete.blueColor),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SimpleButton(onTap: () {
                                      Printing.directPrintPdf(
                                          format: PdfPageFormat.a5,
                                          name: "siht",
                                          printer: Printer(url: "Imprimer"),
                                          onLayout:
                                              (PdfPageFormat format) async =>
                                                  pdfBytes);
                                    },
                                        txt: "Print",
                                        Icons.print,
                                        Pallete.blueColor),
                                    /*Save var printers = Printing.listPrinters();

                      printers.then((value) => print(value));
                      Printing.directPrintPdf(
                          printer: Printer(url: "Microsoft Print To PDF"),
                          onLayout: (PdfPageFormat format) async => pdfBytes);*/
                                    //await Printing.layoutPdf(
                                    //  onLayout: (PdfPageFormat format) async => pdfBytes);
                                  ],
                                )
                              ]),
                            )
                          ]),
                        ));
                  }),
                )
              ]));
    });
  }
}

class RightSideOrdonnance extends StatefulWidget {
  const RightSideOrdonnance(
    this.ordonnanceDetails, {
    super.key,
  });
  final Map<String, String> ordonnanceDetails;

  @override
  State<RightSideOrdonnance> createState() => _RightSideOrdonnanceState();
}

class _RightSideOrdonnanceState extends State<RightSideOrdonnance> {
  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();

// Page
    return LayoutBuilder(builder: (context, constraints) {
      pdfBytes = _generatePdf(PdfPageFormat.a5, widget.ordonnanceDetails);
      return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Overview',
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
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Constants.border,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: PdfPreview(
                            pdfFileName: "shitttt",
                            useActions: false,
                            pageFormats: {
                              "A5": PdfPageFormat.a5,
                              //  "A4": PdfPageFormat.a4,
                            },
                            shouldRepaint: true,
                            initialPageFormat: PdfPageFormat.a5,
                            build: (format) => pdfBytes,
                          ),
                        ));
                  }),
                )
              ]));
    });
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, Map<String, String> ordonnanceDetails) async {
    final pdf = pw.Document(
      title: "shit",
    );
    final font = await PdfGoogleFonts.poppinsMedium();

    pdf.addPage(
      pw.Page(
        // clip: true,
        margin: pw.EdgeInsets.all(18),
        pageFormat: PdfPageFormat.a5,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(children: [
                pw.FittedBox(
                  child: pw.Text("Dida Bilel \nDoctor",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(fontSize: 18, font: font)),
                ),
                pw.Spacer(),
                pw.Padding(
                    padding: pw.EdgeInsets.only(right: 10),
                    child: pw.SizedBox(
                      width: 130,
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Date:"),
                            pw.Text("Nom:${ordonnanceDetails['familyName']}"),
                            pw.Text("Prenom:${ordonnanceDetails['name']}"),
                            pw.Text("Age:${ordonnanceDetails['age']}"),
                          ]),
                    ))
              ]),
              pw.SizedBox(height: 50),
              pw.Container(
                  child: pw.Text(ordonnanceDetails['ordonnance'] ?? '')),
              pw.Spacer(),
              pw.Text('address')
              /*pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),*/
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
