import 'dart:convert';

import 'package:destino_quisqueya_front/contracts/authContract.dart';
import 'package:destino_quisqueya_front/models/authModels/dominicanPerson.dart';
import 'package:http/http.dart' as http;

class AuthService implements AuthContract {
  @override
  Future<DominicanPerson> getPersonByCedula(String cedula) async {
    DominicanPerson? dataResponse;
    try {
      http.Response? response;
      response = await http.get(
        Uri.parse("http://216.172.100.195:8033/cedula/$cedula"),
      );
      if (response.statusCode == 200) {
        dataResponse = DominicanPerson.fromJson(jsonDecode(response.body));
        return dataResponse;
      } else {
        if (response.statusCode == 404) {
          dataResponse = DominicanPerson();
          return dataResponse;
        } else {
          return dataResponse!;
        }
      }
    } catch (e) {
      print(e.toString());
      return dataResponse!;
    }
  }
}
