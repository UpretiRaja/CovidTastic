import 'package:flutter/foundation.dart';

class StudentData with ChangeNotifier {
  final String? id;
  final String? name;
  final double? mobileNumber;
  final String? emailAddress;
  final String? currentLocation;
  final double? universityRollNumber;
  final String? collegeName;
  final String? semester;
  final String? description;

  StudentData({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.emailAddress,
    required this.currentLocation,
    required this.universityRollNumber,
    required this.collegeName,
    required this.semester,
    required this.description,
  });
}
