import 'dart:developer';

import 'package:colin_hanbury_frontend/models/visitor.dart';
import 'package:colin_hanbury_frontend/services/visitor_service.dart';

class AssociatesRepo {
  final AssociatesService associatesAPI = AssociatesService();

  Future<List<Associate>> getVisitors() async {
    List<dynamic> response = await associatesAPI.getAssociates();
    List<Associate> associates =
        response.map((jsonObject) => Associate.fromJson(jsonObject)).toList();
    log(associates.toString());
    return associates;
  }

  Future<dynamic> addAssociate(String name) async {
    return await associatesAPI.addAssociate(name);
  }
}
