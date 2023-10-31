import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:hive/hive.dart';

abstract class LocalStorageRepository {
  final Box<LocalResponseData> localResponseBox;
  final Box<SettingsData> settingsBox;

  const LocalStorageRepository(this.localResponseBox, this.settingsBox);

  // local user data
  void addLocalResponseData(LocalResponseData data);

  Future<LocalResponseData?> getLocalResponseData();

  void removeLocalResponseData();

  // settings data  
  void addSettingsData(SettingsData data);

  Future<SettingsData?> getSettingsData();

  void removeSettingsData();
}