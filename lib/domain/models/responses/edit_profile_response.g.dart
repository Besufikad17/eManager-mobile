// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileResponse _$EditProfileResponseFromJson(Map<String, dynamic> json) =>
    EditProfileResponse(
      json['id'] as String,
      json['fname'] as String,
      json['lname'] as String,
      json['email'] as String,
      json['phonenNumber'] as String,
    );

Map<String, dynamic> _$EditProfileResponseToJson(
        EditProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'phonenNumber': instance.phonenNumber,
      'email': instance.email,
    };
