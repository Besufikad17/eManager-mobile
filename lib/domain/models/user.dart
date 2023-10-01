import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? fname;
  final String? lname;
  final String? email;
  final String? phonenumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.phonenumber,
    this.createdAt,
    this.updatedAt
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      phonenumber: json['phonenumber'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }

  @override
  String toString() {
    return "$fname, $lname";
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    id, 
    fname, 
    lname,
    email,
    phonenumber,
    createdAt,
    updatedAt
  ];
}
