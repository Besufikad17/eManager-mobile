abstract class LocalStorage {
  Future<LocalStorage> getInstance();

  bool contains(String key);

  String? getData(String key);

  void addData(String key, String value);

  void deleteData(String key);
}

