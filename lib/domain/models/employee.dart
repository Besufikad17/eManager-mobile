import 'package:equatable/equatable.dart';
import 'package:cleanarchdemo/utils/constants/enums.dart';

class Employee extends Equatable {
  final int? id;
  final String? name;
  final String? dept;
  final DateTime? dateOfBirth;
  final double? salary;
  final Gender? gender;

  const Employee({
    this.id,
    this.name,
    this.dept,
    this.dateOfBirth,
    this.salary,
    this.gender
  });

  factory Employee.fromJSON(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      dept: json['dept'],
      dateOfBirth: json['dateOfBirth'],
      salary: json['salary'],
      gender: json['gender']
    );
  }

  @override
  String toString() {
    return "$name";
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    id, 
    name, 
    dept, 
    dateOfBirth,
    salary,
    gender
  ];
}
