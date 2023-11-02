import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_account_response.g.dart';

@JsonSerializable()
class DeleteAccountResponse extends Equatable {
  final String status;
  const DeleteAccountResponse(this.status);

  factory DeleteAccountResponse.fromMap(Map<String, dynamic> json) {
    return DeleteAccountResponse(json['message']);
  }

  Map<String, dynamic> toMap() {
    return {
      'message': status
    };
  }

  @override
  List<Object?> get props => [status];
}