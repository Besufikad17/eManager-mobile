part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;
  const ThemeChanged(this.theme);
  
  @override
  List<Object?> get props => [theme];
}

class GetTheme extends ThemeEvent {
  const GetTheme();

  @override
  List<Object?> get props => [];
}

class AddTheme extends ThemeEvent {
  final AppTheme theme;
  const AddTheme(this.theme);

  @override
  List<Object?> get props => [theme];
}


