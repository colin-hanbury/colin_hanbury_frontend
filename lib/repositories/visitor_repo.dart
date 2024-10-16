import 'dart:developer';

import 'package:colin_hanbury_frontend/models/visitor.dart';
import 'package:colin_hanbury_frontend/services/visitor_service.dart';

class VisitorRepo {
  final VisitorService visitorAPI = VisitorService();

  Future<List<Visitor>> getVisitors() async {
    List<dynamic> response = await visitorAPI.getVisitors();
    List<Visitor> visitors =
        response.map((jsonObject) => Visitor.fromJson(jsonObject)).toList();
    log(visitors.toString());
    return visitors;
  }

  Future<dynamic> addNewVisitor(String name) async {
    return await visitorAPI.addVisitor(name);
  }
}
