import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/core/utils.dart';
import 'package:table_prototype/features/patients_screen/repository/clients_repo.dart';
import 'package:table_prototype/features/patients_screen/repository/treatements_repo.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/treatement_model.dart';
import '../repository/antecedents_repo.dart';
part 'treatement_controller.g.dart';

@riverpod
class TreatementNotifier extends _$TreatementNotifier {
  late TreatementRepo treatementsServices;

  @override
  Future<List<Treatement>> build() async {
    List<Treatement> treatement = await getTreatement();

    return treatement;
  }

  void updateState(r) {
    state = AsyncData(r);
  }

  Future<List<Treatement>> getTreatement() async {
    treatementsServices = await ref.watch(treatementsServicesProvider);

    var antecedents = await treatementsServices.getTreatements().then((value) {
      return value;
    }).catchError((e) => {throw "coudln't load treatements $e"});
    // filterCache = clients;

    return antecedents;
  }
}
