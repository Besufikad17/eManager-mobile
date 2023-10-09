import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'local_response_data_service.g.dart';

@HiveType(typeId: 0)
class LocalResponseData extends Equatable {
  @HiveField(0)
  final String token;
  
  @HiveField(1)
  final LocalUser user;

  const LocalResponseData(this.user, this.token);

  @override
  List<Object?> get props => [user, token];
} 