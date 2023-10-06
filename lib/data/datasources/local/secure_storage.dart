import 'package:cleanarchdemo/config/storage/local_storage_config.dart';

abstract class SecureStorage {
  SecuredStorageConfig config;

  SecureStorage(this.config);

  Future<bool> contains(String key);

  Future<String?> getData(String key);

  void addData(String key, String value);

  void deleteData(String key);
}