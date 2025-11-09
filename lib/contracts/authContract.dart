import 'package:destino_quisqueya_front/models/authModels/dominicanPerson.dart';

abstract class AuthContract {
  Future<DominicanPerson> getPersonByCedula(String cedula);
}
