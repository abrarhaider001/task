import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/employee.dart';
import '../services/access_service.dart';

class AccessViewModel {
  List<Employee> employees = [];
  List<AccessResult> results = [];

  Future<void> loadEmployees() async {
    final jsonString = await rootBundle.loadString('assets/employee_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    employees = jsonData.map((e) => Employee.fromJson(e)).toList();
  }

  void simulateAccess() {
    final service = AccessService();
    results = service.simulateAccess(employees);
  }
}
