import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/core/core.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';

part 'app_event.dart';
part 'app_state.dart';

const _authenticationSessionPeriodicRefreshDuration = Duration(minutes: 15);

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository authenticationRepository;

  final DeviceRepository deviceRepository;

  Session authenticationSession;

  Timer? authenticationSessionRefreshTimer;

  AppBloc({
    required this.authenticationRepository,
    required this.deviceRepository,
  })  : authenticationSession = const Session.expired(),
        super(AppInitial(isAuthenticated: false)) {
    on<AppStarted>(
      (event, emit) async {
        final result = await deviceRepository.read(key: sessionKey);

        result.forEach(
          (value) {
            if (value.isSome()) {
              authenticationSession = Session.fromJson(
                jsonDecode(value.toNullable()!) as Map<String, dynamic>,
              );

              _schedulePeriodicSessionRefresh();
            }
          },
        );

        if (authenticationSession.isAlmostExpiring) {
          await _storeSession();
        }

        await Future.delayed(const Duration(seconds: 1));

        final bool isAuthenticated = authenticationSession.hasNotExpired;

        if (isAuthenticated) {
          authenticationRepository.setSession(
            session: authenticationSession,
          );
        }

        emit(
          AppStart(isAuthenticated: isAuthenticated),
        );
      },
    );

    on<AppAuthenticated>(
      (event, emit) async {
        authenticationSession = event.session;

        await _storeSession();

        _schedulePeriodicSessionRefresh();

        emit(
          AppRefresh(
            isAuthenticated: authenticationSession.hasNotExpired,
          ),
        );
      },
    );

    on<RefreshSessionStarted>(
      (event, emit) async {
        final result = await authenticationRepository.refresh(
          session: authenticationSession,
        );

        final state = result.fold(
          (l) => RefreshSessionFailure(
            isAuthenticated: authenticationSession.hasNotExpired,
          ),
          (r) {
            authenticationSession = r;

            return AppRefresh(
              isAuthenticated: authenticationSession.hasNotExpired,
            );
          },
        );

        if (state is! RefreshSessionFailure) {
          await _storeSession();
        }

        emit(state);
      },
    );
  }

  Future<void> _storeSession() {
    return deviceRepository.write(
      key: sessionKey,
      value: authenticationSession.toJson().encode,
    );
  }

  void _schedulePeriodicSessionRefresh() {
    authenticationSessionRefreshTimer?.cancel();

    authenticationSessionRefreshTimer = Timer.periodic(
      _authenticationSessionPeriodicRefreshDuration,
      (timer) {
        add(
          RefreshSessionStarted(),
        );
      },
    );
  }
}
