import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';

part 'users_event.dart';
part 'users_state.dart';

const _limitPerUsersFetch = 20;

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;

  int _currentUsersFetchPage = 0;

  int _lastFetchPage = 0;

  List<User> _fetchedUsers = [];

  UsersBloc({
    required this.usersRepository,
  }) : super(const UsersInitial()) {
    on<FetchUsersEvent>(
      (event, emit) async {
        if (_lastFetchPage == _currentUsersFetchPage) {
          final result = await usersRepository.users(
            page: _currentUsersFetchPage,
            limit: _limitPerUsersFetch,
          );

          _lastFetchPage++;

          final state = result.fold(
            (l) => FetchUsersFailure(
              users: _fetchedUsers,
              hasFetchedAllUsers: this.state.hasFetchedAllUsers,
              error: l,
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
                hasFetchedAllUsers: r.isEmpty,
              );
            },
          );

          emit(state);
        }
      },
    );

    on<RefreshUserEvent>(
      (event, emit) async {
        _fetchedUsers = [
          for (final user in _fetchedUsers)
            if (user.id == event.user.id) event.user else user
        ];

        emit(
          RefreshUsers(
            users: _fetchedUsers,
            hasFetchedAllUsers: state.hasFetchedAllUsers,
          ),
        );
      },
    );
  }
}
