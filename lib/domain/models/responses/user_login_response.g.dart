// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse(
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['token'] as String?,
      json['message'] as String?,
    );

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'message': instance.message,
    };
