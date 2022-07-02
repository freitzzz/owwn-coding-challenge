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
          await deviceRepository.write(
            key: sessionKey,
            value: authenticationSession.toJson().encode,
          );
        }

        emit(
          AppStart(
            isAuthenticated: !authenticationSession.hasExpired,
          ),
        );
      },
    );

    on<AppAuthenticated>(
      (event, emit) async {
        authenticationSession = event.session;

        _schedulePeriodicSessionRefresh();
      },
    );

    on<RefreshSessionStarted>(
      (event, emit) async {
        final result = await authenticationRepository.refresh(
          session: authenticationSession,
        );

        final state = result.fold(
          (l) => RefreshSessionFailure(
            isAuthenticated: !authenticationSession.hasExpired,
          ),
          (r) {
            authenticationSession = r;

            return AppRefresh(
              isAuthenticated: !authenticationSession.hasExpired,
            );
          },
        );

        if (state is! RefreshSessionFailure) {
          await deviceRepository.write(
            key: sessionKey,
            value: authenticationSession.toJson().encode,
          );
        }

        emit(state);
      },
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
