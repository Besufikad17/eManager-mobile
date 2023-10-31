part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final AppTheme appTheme;
  const ThemeState(this.appTheme);
  
  @override
  List<Object> get props => [appTheme];
}

final class ThemeInitial extends ThemeState { 
  const ThemeInitial(): super(AppTheme.light);

  @override
  List<Object> get props => [];
}

final class ThemeLoaded extends ThemeState {
  final AppTheme loadedAppTheme;
  const ThemeLoaded(this.loadedAppTheme): super(loadedAppTheme);
}
