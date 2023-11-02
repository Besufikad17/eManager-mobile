import 'package:equatable/equatable.dart';
import 'package:cleanarchdemo/utils/constants/enums.dart';

class Employee extends Equatable {
  final int? id;
  final String? fname;
  final String? lname;
  final String? profilePictureUrl;
  final String? email;
  final String? phoneNumber;
  final String? dept;
  final DateTime? dateOfBirth;
  final double? salary;
  final Gender? gender;

  const Employee({
    this.id,
    this.fname,
    this.lname,
    this.profilePictureUrl,
    this.email,
    this.phoneNumber,
    this.dept,
    this.dateOfBirth,
    this.salary,
    this.gender
  });

  factory Employee.fromJSON(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      profilePictureUrl: json['profilePictureUrl'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dept: json['dept'],
      dateOfBirth: json['dateOfBirth'],
      salary: json['salary'],
      gender: json['gender']
    );
  }

  @override
  String toString() {
    return "$fname $lname";
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    id, 
    fname,
    lname,
    profilePictureUrl,
    email,
    phoneNumber, 
    dept, 
    dateOfBirth,
    salary,
    gender
  ];
}
