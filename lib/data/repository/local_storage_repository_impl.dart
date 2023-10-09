import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/domain/repositories/local_storage_repository.dart';
import 'package:hive/hive.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final Box<LocalResponseData> box;

  const LocalStorageRepositoryImpl(this.box) : super(box);

  @override
  void addData(LocalResponseData data) async {
    await box.put("response", data);
  }

  @override
  Future<LocalResponseData?> getData() async {
    return box.get("response");
  } 

  @override
  void removeData() async {
    await box.delete("response");
  }

}