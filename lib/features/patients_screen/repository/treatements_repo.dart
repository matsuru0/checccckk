import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_prototype/core/constants/end_points.dart';
import 'package:table_prototype/core/failure.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:http/http.dart' as http;
import 'package:table_prototype/models/treatement_model.dart';
part 'treatements_repo.g.dart';

@riverpod
TreatementRepo treatementsServices(TreatementsServicesRef ref) {
  ref.keepAlive();
  return TreatementRepo();
}

class TreatementRepo {
  Future getTreatements() async {
    try {
      var url = ServerEndPoints.GetTreatements;
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return decodingTreatements(response);
      } else {
        return 'Failed to fetch data';
      }
    } catch (error) {
      throw (error.toString());
    }
  }
}

List<Treatement> decodingTreatements(response) {
  final json = jsonDecode(response.body) as List<dynamic>; //lista

  List<Treatement> treatements = [];
  json.forEach((treatementModel) {
    Treatement treatement = Treatement.fromJson(treatementModel);
    treatements.add(treatement);
  });

  return treatements;
}
