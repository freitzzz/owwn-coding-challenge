import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

const _userNameTextStyle = TextStyle(
  fontSize: 28.0,
);

const _userEmailTextStyle = TextStyle(
  color: Color(0xFFA7A7A7),
  fontSize: 17.0,
);

const _statisticsNotAvailableTextStyle = TextStyle(
  fontSize: 17.0,
);

const _statisticsChartPadding = EdgeInsets.symmetric(
  horizontal: 25.0,
);

const _statisticsChartHeight = 121.0;

const _saveButtonPadding = EdgeInsets.symmetric(
  horizontal: 12.0,
);

class UserView extends StatelessWidget {
  const UserView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final userBloc = context.read<UserBloc>();

    final user = userBloc.state.user;

    AppBarTheme.of(context).toolbarHeight;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight,
        ),
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) =>
              current is UserSaveSuccess ||
              current is UserInitial ||
              (previous is! UserEditInProgress &&
                  current is UserEditInProgress),
          builder: (context, state) {
            return AppBar(
              actions: [
                if (state is UserEditInProgress)
                  IconButton(
                    onPressed: () => AppNavigator.of(context).setNewRoute(
                      const UsersPageArguments(),
                    ),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      body: ListView(
        primary: false,
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return UserAvatar(
                user: state.user,
              );
            },
          ),
          const SizedBox.square(
            dimension: thirtyTwoPoints,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return TextFormField(
                controller: state.nameTextEditingController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                style: _userNameTextStyle,
              );
            },
          ),
          const SizedBox.square(
            dimension: tenPoints,
          ),
          Text(
            user.email,
            textAlign: TextAlign.center,
            style: _userEmailTextStyle,
          ),
          const SizedBox.square(
            dimension: oneHundredPoints,
          ),
          if (user.hasStatistics) ...[
            Padding(
              padding: _statisticsChartPadding,
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(
                  height: _statisticsChartHeight,
                ),
                child: UserStatisticsLineChart(
                  statistics: user.statistics,
                ),
              ),
            ),
            const SizedBox.square(
              dimension: eightPoints,
            ),
            const CustomPaint(
              painter: DashLinePainter(),
            ),
          ] else
            Text(
              localizations.statisticsNotAvailable,
              style: _statisticsNotAvailableTextStyle,
              textAlign: TextAlign.center,
            ),
          const SizedBox.square(
            dimension: twentyFourPoints,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserEditInProgress) {
                return Padding(
                  padding: _saveButtonPadding,
                  child: ElevatedButton(
                    onPressed: _onSaveButtonPressed(
                      userBloc,
                      state.nameTextEditingController,
                    ),
                    child: Text(
                      localizations.saveCaps,
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  VoidCallback? _onSaveButtonPressed(
    final UserBloc userBloc,
    final TextEditingController nameTextEditingController,
  ) {
    VoidCallback? callback;

    if (userBloc.state is! UserSaveInProgress) {
      callback = () {
        userBloc.add(
          UserSaveEvent(),
        );
      };
    }

    return callback;
  }
}
