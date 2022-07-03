import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final User user;

  UserBloc({
    required this.user,
  }) : super(UserInitial(user: user)) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
