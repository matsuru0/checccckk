class TreatementsTypeModel {
  final List<Treatement> treatements;
  const TreatementsTypeModel({required this.treatements});

  Map<String, dynamic> toJson() {
    return {'treatements': treatements};
  }

  @override
  String toString() {
    return 'TreatementsTypeModel( teatements : ${treatements} )';
  }

  factory TreatementsTypeModel.fromJson(Map<String, dynamic> json) {
    print('foking json : $json');
    /*List<Treatement> treatementsList = [];
    if (json != null) {
      var tList = json as List<dynamic>;

      tList.forEach((ant) {
        treatementsList.add(Treatement.fromJson(ant));
      });
    }
    print(treatementsList);*/
    return TreatementsTypeModel(
      treatements: [json[0]],
    );
  }
}

class Treatement {
  final String name;
  final double price;
  final String uid;
  final DateTime? date;
  const Treatement(
      {required this.name,
      required this.price,
      required this.uid,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      '_id': uid,
      'date': date != null ? date!.millisecondsSinceEpoch : null
    };
  }

  Map<String, dynamic> toJsonWithoutNameAndPrice() {
    return {
      'date': date != null ? date!.millisecondsSinceEpoch : null,
      '_id': uid,
    };
  }

  Treatement copyWith({
    String? name,
    double? price,
    String? uid,
    DateTime? date,
  }) {
    return Treatement(
      name: name ?? this.name,
      price: price ?? this.price,
      uid: uid ?? this.uid,
      date: date ?? this.date,
    );
  }

  String toString() {
    return 'Treatement(name : $name , price : ${price} )';
  }

  factory Treatement.fromJson(Map<String, dynamic> json) {
    print("JSON $json");
    return Treatement(
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'])
          : null,
      uid: json["_id"] ?? '',
      name: json['name'] ?? '',
      price: json['price'] != null
          ? double.parse(json['price'].toString())
          : 00.00,
    );
  }
}
