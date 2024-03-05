import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_prototype/core/constants/end_points.dart';
import 'package:table_prototype/core/failure.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:http/http.dart' as http;
part 'antecedents_repo.g.dart';

@riverpod
AntecedentRepo antecedentServices(AntecedentServicesRef ref) {
  ref.keepAlive();
  return AntecedentRepo();
}

class AntecedentRepo {
  Future getAntecedents() async {
    try {
      var url = ServerEndPoints.GetAntecedents;
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return decodingAntecedents(response);
      } else {
        return 'Failed to fetch data';
      }
    } catch (error) {
      throw (error.toString());
    }
  }

  Future editAntecedent(String id, Map<String, dynamic> antecedent) async {
    var url = ServerEndPoints.EditAntecedents;
    try {
      var res = await http.post(
        Uri.parse(url),
        // We serialize our Todo object and POST it to the server.
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(antecedent),
      );

      if (res.statusCode == 200) {
        return right(decodingAntecedents(res));
      } else {
        return left(Failure('Failed to update antecedent'));
      }
    } catch (e) {
      throw 'chunky error :$e';
    }
  }

  Future deleteAntecedent(String id) async {
    var url = ServerEndPoints.DeleteAntecedents + id;

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(decodingAntecedents(response));
      } else {
        return left(Failure('Failed to delete antecedent'));
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future addAntecedent() async {
    var url = ServerEndPoints.AddAntecedent;

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return right(decodingAntecedents(response));
      } else {
        return left(Failure('Failed to add antecedent'));
      }
    } catch (error) {
      throw error.toString();
    }
  }
}

List<AntecedentModel> decodingAntecedents(response) {
  final json = jsonDecode(response.body) as List<dynamic>; //lista

  List<AntecedentModel> antecedents = [];
  json.forEach((antecedentModel) {
    AntecedentModel antecedent = AntecedentModel.fromJson(antecedentModel);
    antecedents.add(antecedent);
  });

  return antecedents;
}
