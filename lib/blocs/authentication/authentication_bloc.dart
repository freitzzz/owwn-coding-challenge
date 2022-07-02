import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>(
      (event, emit) async {
        emit(
          AuthenticationInProgress(),
        );

        final result = await authenticationRepository.auth(
          credentials: Credentials(email: event.email),
        );

        emit(
          result.fold(
            (l) => AuthenticationFailure(error: l),
            (r) => AuthenticationSuccess(session: r),
          ),
        );
      },
    );
  }
}
