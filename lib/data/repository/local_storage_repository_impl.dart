import 'package:cleanarchdemo/config/storage/local_storage_config.dart';
import 'package:cleanarchdemo/data/datasources/local/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl extends SecureStorage {
  FlutterSecureStorage? storage;

  SecureStorageImpl(SecuredStorageConfig config) : super(config) {
    storage = FlutterSecureStorage(aOptions: config.getAndroidOptions());
  }

  @override
  Future<bool> contains(String key) {
    return storage!.containsKey(key: key);
  }

  @override
  Future<String?> getData(String key) {
    return storage!.read(key: key);
  }

  @override
  void addData(String key, String value) {
    storage!.write(key: key, value: value);
  }

  @override
  void deleteData(String key) {
    storage!.delete(key: key);
  }
}