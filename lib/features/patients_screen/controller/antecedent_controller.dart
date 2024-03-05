import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/core/utils.dart';
import 'package:table_prototype/features/patients_screen/repository/clients_repo.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import '../repository/antecedents_repo.dart';
part 'antecedent_controller.g.dart';

@riverpod
class AntecedentNotifier extends _$AntecedentNotifier {
  late AntecedentRepo antecedentServices;

  @override
  Future<List<AntecedentModel>> build() async {
    List<AntecedentModel> antecedents = await getAntecedents();

    return antecedents;
  }

  void updateState(r) {
    state = AsyncData(r);
  }

  Future<List<AntecedentModel>> getAntecedents() async {
    antecedentServices = await ref.watch(antecedentServicesProvider);

    var antecedents = await antecedentServices.getAntecedents().then((value) {
      return value;
    }).catchError((e) => {throw "coudln't load Antecedents $e"});
    // filterCache = clients;

    return antecedents;
  }

  Future editAntecedent(
      String id, Map<String, dynamic> client, BuildContext context) async {
    var res = await antecedentServices.editAntecedent(id, client);
    res.fold((l) => showSnackBar(context, l.message, CustomColors.red), (r) {
      updateState(r);

      showSnackBar(context, 'antecdent edited', CustomColors.green);
    });
  }

  Future deleteAntecedent(String id, BuildContext context) async {
    var res = await antecedentServices.deleteAntecedent(id);
    res.fold((l) => showSnackBar(context, l.message, CustomColors.red), (r) {
      showSnackBar(context, 'antecedent deleted', CustomColors.green);
      updateState(r);
    });
  }

  Future addAntecedent(BuildContext context) async {
    var res = await antecedentServices.addAntecedent();
    res.fold((l) => showSnackBar(context, l.message, CustomColors.red), (r) {
      updateState(r);
      showSnackBar(
          context, 'new antecedent has been created', CustomColors.green);
    });
  }
}
