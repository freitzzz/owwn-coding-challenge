import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/models/user.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _userTilePadding = EdgeInsets.only(
  bottom: twoPoints,
);

const _userStatusLabelPadding = EdgeInsets.symmetric(
  vertical: tenPoints,
);

const _userStatusLabelTextStyle = TextStyle(
  fontSize: eighteenPoints,
);

class UsersView extends StatelessWidget {
  const UsersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return SliverAppBar(
                expandedHeight: 318.0,
                title: constraints.scrollOffset > 200
                    ? Text(
                        localizations.usersTitle,
                      )
                    : null,
                pinned: true,
                stretch: true,
                flexibleSpace: const FlexibleSpaceBar(
                  background: UsersCover(),
                ),
              );
            },
          ),
          BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              final users = state.users;

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: twelvePoints,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final previousUser = index > 0 ? users[index - 1] : null;
                      final currentUser = state.users[index];
                      final nextUser = index + 1 < state.totalCount
                          ? users[index + 1]
                          : null;

                      final isFirstActiveUser = _isFirstActiveUser(
                        previousUser,
                        currentUser,
                      );

                      final isLastActiveUser = _isLastActiveUser(
                        currentUser,
                        nextUser,
                      );

                      final isFirstInactiveUser = _isFirstInactiveUser(
                        previousUser,
                        currentUser,
                      );

                      final isLastInactiveUser = _isLastInactiveUser(
                        currentUser,
                        nextUser,
                      );

                      if (isFirstActiveUser) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: _userStatusLabelPadding,
                              child: Text(
                                localizations.active,
                                style: _userStatusLabelTextStyle,
                              ),
                            ),
                            Padding(
                              padding: _userTilePadding,
                              child: UserListTile(
                                isFirstInGroup:
                                    isFirstActiveUser && !isLastActiveUser,
                                isLastInGroup:
                                    !isFirstActiveUser && isLastActiveUser,
                                user: currentUser,
                              ),
                            ),
                          ],
                        );
                      } else if (isFirstInactiveUser) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: _userStatusLabelPadding,
                              child: Text(
                                localizations.inactive,
                                style: _userStatusLabelTextStyle,
                              ),
                            ),
                            Padding(
                              padding: _userTilePadding,
                              child: UserListTile(
                                isFirstInGroup:
                                    isFirstInactiveUser && !isLastInactiveUser,
                                isLastInGroup:
                                    !isFirstInactiveUser && isLastInactiveUser,
                                user: currentUser,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: _userTilePadding,
                          child: UserListTile(
                            isFirstInGroup:
                                isFirstActiveUser || isFirstInactiveUser,
                            isLastInGroup:
                                isLastActiveUser || isLastInactiveUser,
                            user: currentUser,
                          ),
                        );
                      }
                    },
                    childCount: state.totalCount,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _isFirstActiveUser(final User? previousUser, final User currentUser) {
    if (previousUser == null && currentUser.active) {
      return true;
    } else if (previousUser != null &&
        !previousUser.active &&
        currentUser.active) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLastActiveUser(final User currentUser, final User? nextUser) {
    if (nextUser == null && currentUser.active) {
      return true;
    } else if (nextUser != null && !nextUser.active && currentUser.active) {
      return true;
    } else {
      return false;
    }
  }

  bool _isFirstInactiveUser(final User? previousUser, final User currentUser) {
    if (previousUser == null && !currentUser.active) {
      return true;
    } else if (previousUser != null &&
        previousUser.active &&
        !currentUser.active) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLastInactiveUser(final User currentUser, final User? nextUser) {
    if (nextUser == null && !currentUser.active) {
      return true;
    } else if (nextUser != null && nextUser.active && !currentUser.active) {
      return true;
    } else {
      return false;
    }
  }
}
