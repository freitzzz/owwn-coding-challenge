part of 'app_bloc.dart';

abstract class AppState {
  final bool isAuthenticated;

  const AppState({
    required this.isAuthenticated,
  });
}

class AppInitial extends AppState {
  AppInitial({
    required super.isAuthenticated,
  });
}

class AppStart extends AppState {
  AppStart({
    required super.isAuthenticated,
  });
}

class AppRefresh extends AppState {
  AppRefresh({
    required super.isAuthenticated,
  });
}
