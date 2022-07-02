import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final DeviceRepository deviceRepository;

  Session authenticationSession;

  AppBloc({
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
            }
          },
        );

        emit(
          AppStart(
            isAuthenticated: authenticationSession.hasExpired,
          ),
        );
      },
    );
  }
}
