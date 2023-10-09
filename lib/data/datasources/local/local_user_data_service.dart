import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'local_user_data_service.g.dart';

@HiveType(typeId: 1)
class LocalUser extends Equatable {
  @HiveField(0)
  final int? id;
  
  @HiveField(1)
  final String? fname;
  
  @HiveField(2)
  final String? lname;
  
  @HiveField(3)
  final String? email;
  
  @HiveField(4)
  final String? phonenumber;
  
  @HiveField(5)
  final DateTime? createdAt;
  
  @HiveField(6)
  final DateTime? updatedAt;

  const LocalUser(
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.phonenumber,
    this.createdAt,
    this.updatedAt
  );

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