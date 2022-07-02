part of 'app_bloc.dart';

abstract class AppEvent {}

class AppStarted extends AppEvent {}

class AppAuthenticated extends AppEvent {
  final Session session;

  AppAuthenticated({
    required this.session,
  });
}

@visibleForTesting
class RefreshSessionStarted extends AppEvent {}
