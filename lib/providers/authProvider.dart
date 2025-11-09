import 'package:destino_quisqueya_front/contracts/authContract.dart';
import 'package:destino_quisqueya_front/models/authModels/dominicanPerson.dart';
import 'package:flutter/material.dart';

class Authprovider extends ChangeNotifier {
  final AuthContract _contract;

  Authprovider(this._contract);

  Future<DominicanPerson> getPersonByCedula(String cedula) {
    final response = _contract.getPersonByCedula(cedula);
    return response;
  }
}
