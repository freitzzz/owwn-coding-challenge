import 'package:fl_chart/fl_chart.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

class UserStatisticsLineChart extends StatelessWidget {
  final List<double> statistics;

  const UserStatisticsLineChart({
    required this.statistics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < statistics.length; i++)
                FlSpot(
                  i.toDouble(),
                  statistics[i],
                ),
            ],
            isCurved: true,
            dotData: FlDotData(
              show: false,
            ),
            color: theme.colorScheme.onBackground,
          ),
        ],
        titlesData: FlTitlesData(
          show: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: fourPoints,
          ),
        ),
      ),
    );
  }
}
