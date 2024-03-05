import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/core/utils.dart';
import 'package:table_prototype/features/patients_screen/repository/clients_repo.dart';
import 'package:table_prototype/models/client_model.dart';

part 'clients_controller.g.dart';

//Controller handle user requests (connect the  view and services)
//handling errors and data validation & logic
@riverpod
class ClientNotifier extends _$ClientNotifier {
  late ClientRepo clientServices;
  late String sortCached = '';
  late String searchStringCached = ''; //target of search bar
  late List<String> filterCached = [];
  late String lookUpSettings = 'familyName';

  @override
  Future<List<ClientModel>> build({String sort = 'date'}) async {
    sortCached = sort;
    return await getClients([''], '', sort, '');
  }

  void updateState(r) {
    state = AsyncData(r);
  }

  Future<List<ClientModel>> getClients(List<String> query, searchTarget,
      String sortCached, String lookUpSettings) async {
    clientServices = await ref.watch(clientServicesProvider);

    var clients = await clientServices
        .getClients(query, searchTarget, sortCached, lookUpSettings)
        .then((value) {
      return value;
    }).catchError((e) => {throw "coudln't load clients $e"});
    // filterCache = clients;

    return clients;
  }

  Future deleteClient(String id) async {
    var res = await clientServices.deleteUser(id);
    res.fold(
        (l) => /*showSnackBar(context, l.message, CustomColors.red)*/ print(''),
        (r) {
      /*   showSnackBar(context, 'client deleted', CustomColors.green);*/
      updateState(r);
    });
  }

  Future editClient(
      String id, Map<String, dynamic> client, BuildContext context) async {
    var res = await clientServices.editClient(id, client);
    res.fold((l) => showSnackBar(context, l.message, CustomColors.red), (r) {
      updateState(r);

      showSnackBar(context, 'client edited', CustomColors.green);
    });
  }

  Future addClient(BuildContext context) async {
    var res = await clientServices.addClient();
    res.fold((l) => showSnackBar(context, l.message, CustomColors.red), (r) {
      updateState(r);
      showSnackBar(context, 'new client has been created', CustomColors.green);
    });
  }

  void setLookUpSetting(String newLookUpSettings) {
    lookUpSettings = newLookUpSettings;
  }

  Future clientLookUp(String target) async {
    // var sortCached = 'appointements';
    searchStringCached = target;
    //  print(target);
    var filtered = await getClients(
        filterCached, searchStringCached, sortCached, lookUpSettings);
    // print(filtered);
    state = AsyncData(filtered);
  }

  Future clientFilter(List<String> query) async {
    filterCached = query;

    var filtered = await getClients(query, searchStringCached, sortCached,
        lookUpSettings); //we get the new queried list of clients and we apply the search filter to it
    //clientLookUp(filtered, tg);
    state = AsyncData(filtered);
  }

  Future clientSort(String sort) async {
    sortCached = sort;
    var filtered = await getClients(
        filterCached,
        searchStringCached,
        sortCached,
        lookUpSettings); //we get the new queried list of clients and we apply the search filter to it
    //clientLookUp(filtered, tg);
    state = AsyncData(filtered);
  }
}
