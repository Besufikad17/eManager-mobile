import 'package:cleanarchdemo/data/datasources/local/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl extends LocalStorage {
  static LocalStorageImpl? _instance;
  static SharedPreferences? _preferences;

  @override
  Future<LocalStorageImpl> getInstance() async {
     _instance ??= LocalStorageImpl();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  @override
  bool contains(String key) {
    return _preferences!.getString(key) != null;
  }

  @override
  String? getData(String key) {
    return _preferences!.getString(key);
  }

  @override
  void addData(String key, String value) {
    _preferences!.setString(key, value);
  }

  @override
  void deleteData(String key) {
    _preferences!.remove(key);
  }
}