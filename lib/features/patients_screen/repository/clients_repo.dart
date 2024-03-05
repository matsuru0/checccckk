import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_prototype/core/constants/end_points.dart';
import 'package:table_prototype/core/failure.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/client_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'clients_repo.g.dart';
//THIS FILE DO FOKING REQUEST (GET POST ETC....)

/*@riverpod
Future<List<ClientModel>> clients(ClientsRef ref) async {
  var url = ServerEndPoints.GetClients;
  final response = await http.get(Uri.parse(url));

  final json = jsonDecode(response.body) as List<dynamic>; //lista

  List<ClientModel> clients = [];
  json.forEach((clientModel) {
    ClientModel client = ClientModel.fromJson(clientModel);
    clients.add(client);
  });

  return clients;
}
*/

//singelton pattern
@riverpod
ClientRepo clientServices(ClientServicesRef ref) {
  ref.keepAlive();

  return ClientRepo();
}

class ClientRepo {
  Future getClients(
      query, searchString, String sortCached, String lookUpSettings) async {
    try {
      var url = ServerEndPoints.GetClients;

      if (sortCached.isNotEmpty) {
        if (url.contains('?')) {
          url += '&sort=$sortCached';
        } else {
          url += '?sort=$sortCached';
        }
      }

      /* if (query.isNotEmpty) {
        var villeQuery = query.join('&ville=');

        if (url.contains('?')) {
          url += '&ville=$villeQuery';
        } else {
          url += '?ville=$villeQuery';
        }
      }*/
      if (lookUpSettings.isNotEmpty) {
        if (url.contains('?')) {
          url += '&lookUpSettings=$lookUpSettings';
        } else {
          url += '?lookUpSettings=$lookUpSettings';
        }
      }
      if (searchString.isNotEmpty) {
        if (url.contains('?')) {
          url += '&searchString=$searchString';
        } else {
          url += '?searchString=$searchString';
        }
      }

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return decodingClients(response);
      } else {
        return 'Failed to fetch data';
      }
    } catch (error) {
      throw (error.toString());
    }
  }

  Future deleteUser(String id) async {
    var url = ServerEndPoints.DeleteClient + id;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(decodingClients(response));
      } else {
        return left(Failure('Failed to delete client'));
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future editClient(String id, Map<String, dynamic> client) async {
    var url = ServerEndPoints.EditClient;
    try {
      var res = await http.post(
        Uri.parse(url),
        // We serialize our Todo object and POST it to the server.
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(client),
      );

      if (res.statusCode == 200) {
        return right(decodingClients(res));
      } else {
        return left(Failure('Failed to update client'));
      }
    } catch (e) {
      throw 'chunky error :$e';
    }
  }

  Future addClient() async {
    var url = ServerEndPoints.AddClient;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return right(decodingClients(response));
      } else {
        return left(Failure('Failed to add client'));
      }
    } catch (error) {
      throw error.toString();
    }
  }
}

List<ClientModel> decodingClients(response) {
  final json = jsonDecode(response.body) as List<dynamic>; //lista

  List<ClientModel> clients = [];
  json.forEach((clientModel) {
    ClientModel client = ClientModel.fromJson(clientModel);

    clients.add(client);
  });

  return clients;
}
