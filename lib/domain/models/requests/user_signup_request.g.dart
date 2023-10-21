// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpRequest _$UserSignUpRequestFromJson(Map<String, dynamic> json) =>
    UserSignUpRequest(
      json['fname'] as String,
      json['lname'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$UserSignUpRequestToJson(UserSignUpRequest instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
    };
