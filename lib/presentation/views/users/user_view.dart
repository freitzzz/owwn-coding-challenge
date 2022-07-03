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

class UserView extends StatelessWidget {
  const UserView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final userBloc = context.read<UserBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final user = state.user;

          return ListView(
            primary: false,
            children: [
              UserAvatar(
                user: user,
              ),
              const SizedBox.square(
                dimension: thirtyTwoPoints,
              ),
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: _userNameTextStyle,
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
            ],
          );
        },
      ),
    );
  }
}
