import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';

part 'users_event.dart';
part 'users_state.dart';

const _limitPerUsersFetch = 20;

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;

  int _currentUsersFetchPage = 0;

  List<User> _fetchedUsers = [];

  UsersBloc({
    required this.usersRepository,
  }) : super(const UsersInitial()) {
    on<FetchUsersEvent>(
      (event, emit) async {
        final result = await usersRepository.users(
          page: _currentUsersFetchPage,
          limit: _limitPerUsersFetch,
        );

        final state = result.fold(
          (l) => FetchUsersFailure(
            users: _fetchedUsers,
            limit: _limitPerUsersFetch,
          ),
          (r) {
            _fetchedUsers = [
              ..._fetchedUsers,
              ...r.where((x) => x.active),
              ...r.where((x) => !x.active),
            ];

            _currentUsersFetchPage++;

            return FetchUsersSuccess(
              users: _fetchedUsers,
              limit: _limitPerUsersFetch,
            );
          },
        );

        emit(state);
      },
    );
  }
}
