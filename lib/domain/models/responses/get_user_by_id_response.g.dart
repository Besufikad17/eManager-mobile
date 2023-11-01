// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_by_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserByIdResponse _$GetUserByIdResponseFromJson(Map<String, dynamic> json) =>
    GetUserByIdResponse(
      json['id'] as String,
      json['fname'] as String,
      json['lname'] as String,
      json['email'] as String,
      json['phonenNumber'] as String,
    );

Map<String, dynamic> _$GetUserByIdResponseToJson(
        GetUserByIdResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'phonenNumber': instance.phonenNumber,
      'email': instance.email,
    };
