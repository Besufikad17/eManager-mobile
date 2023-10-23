import 'package:json_annotation/json_annotation.dart';

part 'get_pfp_response.g.dart';

@JsonSerializable()
class GetPFPResponse {
  final List<dynamic> images;

  const GetPFPResponse(this.images);

  factory GetPFPResponse.fromMap(Map<String, dynamic> json) {
    return GetPFPResponse(json['images']);
  }

  Map<String, dynamic> toMap() {
    return {
      'images': images
    };
  }
}