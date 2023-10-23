// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationRequest _$VerificationRequestFromJson(Map<String, dynamic> json) =>
    VerificationRequest(
      json['code'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$VerificationRequestToJson(
        VerificationRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
