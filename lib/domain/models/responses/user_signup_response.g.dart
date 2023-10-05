// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpResponse _$UserSignUpResponseFromJson(Map<String, dynamic> json) =>
    UserSignUpResponse(
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['token'] as String,
    );

Map<String, dynamic> _$UserSignUpResponseToJson(UserSignUpResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
