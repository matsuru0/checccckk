class AntecedentHistory {
  final String uid;
  final String date;
  final String value;

  const AntecedentHistory(
      {required this.value, required this.uid, required this.date});

  Map<String, dynamic> toJson() {
    return {'value': value, '_id': uid, 'date': date};
  }

  @override
  String toString() {
    return 'AntHistory(value : $value | date : $date)';
  }

  factory AntecedentHistory.fromJson(Map<String, dynamic> json) {
    return AntecedentHistory(
        date: json['date'] ?? '',
        value: json['value'] ?? '',
        uid: json['_id'] ?? '');
  }
}

class AntecedentModel {
  final String title;
  final String value;
  final String uid;
  final List<AntecedentHistory> history;
  const AntecedentModel(
      {required this.title,
      required this.value,
      required this.uid,
      required this.history});

  factory AntecedentModel.fromJson(Map<String, dynamic> json) {
    List<AntecedentHistory> historyMapList = [];
    if (json['history'] != null) {
      var historyList = json['history'] as List<dynamic>;

      historyList.forEach((ant) {
        historyMapList.add(AntecedentHistory.fromJson(ant));
      });
    }

    return AntecedentModel(
        history: historyMapList ?? [],
        title: json['title'] ?? '',
        value: json['value'] ?? '',
        uid: json['_id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'value': value, '_id': uid, 'history': history};
  }

  @override
  String toString() {
    return 'Antecedent(Title:$title | value:$value , history:$history)';
  }

  AntecedentModel copyWith({
    String? title,
    String? value,
    String? uid,
    List<AntecedentHistory>? history,
  }) {
    return AntecedentModel(
      history: history ?? this.history,
      title: title ?? this.title,
      value: value ?? this.value,
      uid: uid ?? this.uid,
    );
  }
}
