import 'package:intl/intl.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/treatement_model.dart';

class Visit {
  final DateTime date;
  final Consultation consultation;
  final List<Treatement> treatements;

  const Visit(
      {required this.date,
      required this.treatements,
      required this.consultation});
  factory Visit.fromJson(Map<String, dynamic> json) {
    print(json);
    return Visit(
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      consultation: Consultation.fromJson(json['consultation']),
      treatements: (json['treatements'] as List<dynamic>)
          .map((treatementJson) => Treatement.fromJson(treatementJson))
          .toList(),
    );
  }

  Visit copyWith({
    DateTime? date,
    Consultation? consultation,
    List<Treatement>? treatements,
  }) {
    return Visit(
      date: date ?? this.date,
      consultation: consultation ?? this.consultation,
      treatements: treatements ?? this.treatements,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.millisecondsSinceEpoch,
      'consultation': consultation.toJson(),
      'treatements': treatements
          .map((treatement) => treatement.toJsonWithoutNameAndPrice())
          .toList(),
    };
  }
}

class ClientModel {
  final String name;
  final String familyName;
  final int age;
  final DateTime? birthdayDate;
  final DateTime? appointement;
  final String uid;
  final String phone;
  final String ville;
  final String lastVisit;
  final String address;
  final String addressEmail;
  final String assurance;
  final bool isInWaitingRoom;
  final bool isAman;
  final List<Visit> visits;
  /* final List<Consultation> consultations;
  final List<Treatement> treatements;*/
  final List<AntecedentModel> antecedents;
//ClientModel(ville:'',age: 0,familyName:'',name:'Patient',lastVisit: "",phone:'',uid:'') ;
  ClientModel(
      {required this.name,
      required this.age,
      required this.addressEmail,
      required this.address,
      required this.assurance,
      required this.birthdayDate,
      required this.appointement,
      required this.familyName,
      required this.uid,
      required this.phone,
      required this.ville,
      required this.isAman,
      required this.lastVisit,
      required this.isInWaitingRoom,
      required this.antecedents,
      required this.visits
      /*required this.consultations,
      required this.treatements*/
      });

  ClientModel copyWith({
    String? name,
    String? familyName,
    String? uid,
    String? phone,
    String? ville,
    int? age,
    bool? isAman,
    String? lastVisit,
    bool? isInWaitingRoom,
    DateTime? birthdayDate,
    DateTime? appointement,
    String? address,
    String? addressEmail,
    String? assurance,
    List<AntecedentModel>? antecedents,
    List<Visit>? visits,
    /* List<Consultation>? consultations,
    List<Treatement>? treatements,*/
  }) {
    return ClientModel(
      /*  treatements: treatements ?? this.treatements,
      consultations: consultations ?? this.consultations,*/
      visits: visits ?? this.visits,
      address: address ?? this.address,
      addressEmail: addressEmail ?? this.addressEmail,
      assurance: assurance ?? this.assurance,
      appointement: appointement ?? this.appointement,
      birthdayDate: birthdayDate ?? this.birthdayDate,
      isAman: isAman ?? this.isAman,
      isInWaitingRoom: isInWaitingRoom ?? this.isInWaitingRoom,
      antecedents: antecedents ?? this.antecedents,
      age: age ?? this.age,
      name: name ?? this.name,
      familyName: familyName ?? this.familyName,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      ville: ville ?? this.ville,
      lastVisit: lastVisit ?? this.lastVisit,
    );
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    List<AntecedentModel> antecedents = [];
    var antecedentJson = json['antecedents'];

    antecedentJson.forEach((ant) {
      antecedents.add(AntecedentModel.fromJson(ant));
    });

    List<Visit> visits = [];
    var visitsJson = json['visits'];
    if (visitsJson.length > 0 && visitsJson != null) {
      visitsJson.forEach((ant) {
        visits.add(Visit.fromJson(ant));
      });
    }

    /* List<Consultation> consultations = [];
    var consultationsJson = json['consultations'];
    consultationsJson.forEach((ant) {
      consultations.add(Consultation.fromJson(ant));
    });

    List<Treatement> treatements = [];
    var treatementsJson = json['treatements'];
    treatementsJson.forEach((ant) {
      treatements.add(Treatement.fromJson(ant));
    });*/

    return ClientModel(
      visits: visits ?? [],
      //  treatements: treatements ?? [],
      address: json['address'] ?? '',
      addressEmail: json['addressEmail'] ?? '',
      assurance: json['assurance'] ?? '',
      appointement: json['appointement'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['appointement'])
          : null,
      birthdayDate: json['birthdayDate'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['birthdayDate'])
          : null,
      isAman: json['isAman'] ?? false,
      isInWaitingRoom: json['isInWaitingRoom'] ?? false,
      //  consultations: consultations ?? [],
      antecedents: antecedents ?? [],
      name: json['name'] ?? '',
      familyName: json['familyName'] ?? '',
      age: json['age'] ?? '',
      phone: json['phone'] ?? '',
      uid: json['_id'] ?? '',
      ville: json['ville'] ?? '',
      lastVisit: json['lastVisit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visits': visits,

      ///   'treatements': treatements,
      'address': address,
      'addressEmail': addressEmail,
      'assurance': assurance,
      'appointement':
          appointement != null ? appointement?.millisecondsSinceEpoch : null,
      'birthdayDate': birthdayDate != null
          ? DateFormat('yyyy-MM-dd').format(birthdayDate!.toLocal())
          : null,
      'isAman': isAman,
      'isInWaitingRoom': isInWaitingRoom,
      'antecedents': antecedents,
      //'consultations': consultations,
      'name': name,
      'familyName': familyName,
      'age': age,
      'phone': phone,
      '_id': uid,
      'ville': ville,
      'lastVisit': lastVisit,
    };
  }

  @override
  String toString() {
    return '(name: $name, familyName: $familyName)';
  }
}

class Consultation {
  final String value;
  final DateTime date;

  const Consultation({required this.value, required this.date});

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      value: json['value'],
      date: DateTime.fromMillisecondsSinceEpoch(
          json['date']), // Assuming the date is in a valid string format
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'date':
          date.millisecondsSinceEpoch, // Convert DateTime to a string format
    };
  }
}
