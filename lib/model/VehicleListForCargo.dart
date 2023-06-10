import 'dart:convert';

class CargoDriver {
  final int id;
  final String driver;
  final String cargo;
  final String vehicleOwner;
  final String plateNumber;

  CargoDriver({
    required this.id,
    required this.driver,
    required this.cargo,
    required this.vehicleOwner,
    required this.plateNumber,
  });

  factory CargoDriver.fromJson(Map<String, dynamic> json) {
    return CargoDriver(
      id: json['id'],
      driver: json['driver'],
      cargo: json['cargo'],
      vehicleOwner: json['vehicleOwner'],
      plateNumber: json['plateNumber'],
    );
  }
}
