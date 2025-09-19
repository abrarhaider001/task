class RoomRule {
  final String name;
  final int minAccessLevel;
  final DateTime openTime;
  final DateTime closeTime;
  final int cooldownMinutes;

  RoomRule({
    required this.name,
    required this.minAccessLevel,
    required this.openTime,
    required this.closeTime,
    required this.cooldownMinutes,
  });
}

List<RoomRule> roomRules = [
  RoomRule(
    name: "ServerRoom",
    minAccessLevel: 2,
    openTime: DateTime(2025, 1, 1, 9, 0),
    closeTime: DateTime(2025, 1, 1, 11, 0),
    cooldownMinutes: 15,
  ),
  RoomRule(
    name: "Vault",
    minAccessLevel: 3,
    openTime: DateTime(2025, 1, 1, 9, 0),
    closeTime: DateTime(2025, 1, 1, 10, 0),
    cooldownMinutes: 30,
  ),
  RoomRule(
    name: "R&D Lab",
    minAccessLevel: 1,
    openTime: DateTime(2025, 1, 1, 8, 0),
    closeTime: DateTime(2025, 1, 1, 12, 0),
    cooldownMinutes: 10,
  ),
];
