import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_by_id_response.g.dart';

@JsonSerializable()
class GetUserByIdResponse extends Equatable {
  final String id;
  final String fname;
  final String lname;
  final String phonenNumber;
  final String email;

  const GetUserByIdResponse(this.id, this.fname, this.lname, this.email, this.phonenNumber);

  factory GetUserByIdResponse.fromMap(Map<String, dynamic> json) {
    return GetUserByIdResponse(
      json['data']['id'].toString(), 
      json['data']['fname'], 
      json['data']['lname'],
      json['data']['email'], 
      json['data']['phoneNumber']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phoneNumber': phonenNumber
    };
  }

  @override
  List<Object?> get props => [id, fname, lname, email, phonenNumber];
}
