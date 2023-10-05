// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginRequest _$UserLoginRequestFromJson(Map<String, dynamic> json) =>
    UserLoginRequest(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$UserLoginRequestToJson(UserLoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
