import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest extends Equatable {
  final String fname;
  final String lname;
  final String phoneNumber;
  final String email;

  const EditProfileRequest(this.fname, this.lname, this.email, this.phoneNumber);

  factory EditProfileRequest.fromMap(Map<String, dynamic> json) {
    return EditProfileRequest(
      json['fname'], 
      json['lname'], 
      json['email'],
      json['phoneNumber']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'phoneNumber': phoneNumber
    };
  }

  @override
  List<Object?> get props => [fname, lname, email, phoneNumber];
}