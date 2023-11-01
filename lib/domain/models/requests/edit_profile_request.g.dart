// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequest _$EditProfileRequestFromJson(Map<String, dynamic> json) =>
    EditProfileRequest(
      json['fname'] as String,
      json['lname'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
    );

Map<String, dynamic> _$EditProfileRequestToJson(EditProfileRequest instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };
