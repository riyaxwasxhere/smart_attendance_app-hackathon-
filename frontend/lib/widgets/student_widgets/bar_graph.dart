import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({
    super.key,
    required this.totalDays,
    required this.daysPresent,
    required this.daysAbsent,
  });

  final int totalDays;
  final int daysPresent;
  final int daysAbsent;

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1), // Slow down animation
      builder: (context, animationValue, child) {
        return BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.black, width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getBottomtitles,
                  reservedSize: 30,
                ),
              ),
            ),
            maxY: 30,
            minY: 0,
            barGroups: _getBarGroups(animationValue), // Pass animation value
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _getBarGroups(double animationValue) {
    return [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: widget.totalDays * animationValue, // Apply animation
            color: const Color.fromARGB(255, 85, 166, 233),
            width: 40,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: widget.daysPresent * animationValue, // Apply animation
            color: const Color.fromARGB(255, 76, 176, 71),
            width: 40,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: widget.daysAbsent * animationValue, // Apply animation
            color: const Color.fromARGB(255, 219, 55, 55),
            width: 40,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    ];
  }

  Widget getBottomtitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text("Total", style: style);
        break;
      case 2:
        text = const Text("Present", style: style);
        break;
      case 3:
        text = const Text("Absent", style: style);
        break;
      default:
        text = const Text("");
        break;
    }

    return SideTitleWidget(meta: meta, child: text);
  }
}
