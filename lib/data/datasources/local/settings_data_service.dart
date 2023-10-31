import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'settings_data_service.g.dart';

@HiveType(typeId: 2)
enum AppTheme {
  @HiveField(0)
  light,

  @HiveField(1)
  dark
}

@HiveType(typeId: 3)
enum AppLanguage {
  @HiveField(0)
  english,

  @HiveField(1)
  amharic
}

@HiveType(typeId: 4)
class SettingsData extends Equatable {
  @HiveField(0)
  final AppTheme theme;

  @HiveField(1)
  final AppLanguage language;

  const SettingsData(this.theme, this.language);

  @override
  List<Object?> get props => [theme, language];
}