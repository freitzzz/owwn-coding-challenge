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
                      closeIconData,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final user = state.user;

          return ListView(
            primary: false,
            children: [
              UserAvatar(
                user: state.user,
              ),
              const SizedBox.square(
                dimension: thirtyTwoPoints,
              ),
              TextFormField(
                controller: state.nameTextEditingController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                style: _userNameTextStyle,
              ),
              const SizedBox.square(
                dimension: tenPoints,
              ),
              TextFormField(
                controller: state.emailTextEditingController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
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
                    child: const _UserStatisticsChart(),
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
              if (state is UserEditInProgress)
                Padding(
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
                ),
            ],
          );
        },
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

class _UserStatisticsChart extends StatelessWidget {
  const _UserStatisticsChart();

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    final user = userBloc.state.user;

    return UserStatisticsLineChart(
      statistics: user.statistics,
    );
  }
}
