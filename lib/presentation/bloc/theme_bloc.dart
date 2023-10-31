import 'package:bloc/bloc.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalStorageRepositoryImpl _repository; 

  ThemeBloc(this._repository) : super(const ThemeInitial()) {
    
    on<GetTheme>((event, emit) async {
      final theme = await _repository.getSettingsData();
      emit(ThemeLoaded(theme!.theme));
    });

    on<AddTheme>((event, emit) async {
      final setting = await _repository.getSettingsData();
      _repository.addSettingsData(
        SettingsData(event.theme, setting!.language)
      );
      emit(ThemeLoaded(event.theme));
    });

    on<ThemeChanged>((event, emit) async {
      final setting = await _repository.getSettingsData();
      _repository.addSettingsData(
        SettingsData(event.theme, setting != null ? setting.language : AppLanguage.english)
      );
      locator.registerSingleton(event.theme);
      emit(ThemeLoaded(event.theme));
    });

  }
}
