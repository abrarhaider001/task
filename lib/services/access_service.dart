import '../model/employee.dart';
import '../model/room_rules.dart';

class AccessResult {
  final Employee employee;
  final bool granted;
  final String reason;

  AccessResult(this.employee, this.granted, this.reason);
}

class AccessService {
  final Map<String, DateTime> lastAccessTimes = {};

  List<AccessResult> simulateAccess(List<Employee> employees) {
    List<AccessResult> results = [];

    for (var emp in employees) {
      final roomRule = roomRules.firstWhere(
        (r) => r.name == emp.room,
        orElse: () => throw Exception("Room not found"),
      );

      if (emp.accessLevel < roomRule.minAccessLevel) {
        results.add(
          AccessResult(emp, false, "Denied: Below required access level"),
        );
        continue;
      }

      if (emp.requestTime.isBefore(roomRule.openTime) ||
          emp.requestTime.isAfter(roomRule.closeTime)) {
        results.add(AccessResult(emp, false, "Denied: Room closed"));
        continue;
      }

      final lastAccessKey = "${emp.id}-${emp.room}";
      if (lastAccessTimes.containsKey(lastAccessKey)) {
        final lastTime = lastAccessTimes[lastAccessKey]!;
        final diff = emp.requestTime.difference(lastTime).inMinutes;
        if (diff < roomRule.cooldownMinutes) {
          results.add(
            AccessResult(emp, false, "Denied: Cooldown not completed"),
          );
          continue;
        }
      }

      lastAccessTimes[lastAccessKey] = emp.requestTime;
      results.add(AccessResult(emp, true, "Access granted to ${emp.room}"));
    }

    return results;
  }
}
