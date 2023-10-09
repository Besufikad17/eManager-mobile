import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:hive/hive.dart';

abstract class LocalStorageRepository {
  final Box<LocalResponseData> box;

  const LocalStorageRepository(this.box);

  void addData(LocalResponseData data);

  Future<LocalResponseData?> getData();

  void removeData();
}