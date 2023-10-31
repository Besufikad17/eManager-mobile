import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:cleanarchdemo/domain/repositories/local_storage_repository.dart';
import 'package:hive/hive.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final Box<LocalResponseData> localResponseBox;
  final Box<SettingsData> settingsBox;

  const LocalStorageRepositoryImpl(this.localResponseBox, this.settingsBox) : super(localResponseBox, settingsBox);

  @override
  void addLocalResponseData(LocalResponseData data) async {
    await localResponseBox.put("response", data);
  }

  @override
  Future<LocalResponseData?> getLocalResponseData() async {
    return localResponseBox.get("response");
  } 

  @override
  void removeLocalResponseData() async {
    await localResponseBox.delete("response");
  }

  @override
  void addSettingsData(SettingsData data) async {
    await settingsBox.put("settings", data);
  }

  @override
  Future<SettingsData?> getSettingsData() async {
    return settingsBox.get("settings");
  }

  @override
  void removeSettingsData() async {
    await settingsBox.delete("settings");
  }

}