import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/main_screen/models/chart_view_models/line_chart_item_group_view_model.dart';
import 'package:expenzo/main_screen/models/chart_view_models/line_chart_view_model.dart';
import 'package:expenzo/theme/export.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomLineChart extends StatefulWidget {
  final LineChartViewModel viewModel;

  const CustomLineChart({
    required this.viewModel,
    super.key,
  });

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  late List<LineChartBarData> lineChartBarData = [];
  late List<String> titles;

  @override
  void initState() {
    titles = widget.viewModel.dates
        .map(
          (e) => DateFormat('MMM dd').format(e),
        )
        .toList();

    lineChartBarData = widget.viewModel.itemGroups
        .map((e) => createLineChartBarData(e))
        .toList();

    super.initState();
  }

  LineChartBarData createLineChartBarData(
    LineChartItemGroupViewModel group,
  ) {
    final List<FlSpot> spots = group.items
        .map((e) => FlSpot(
              group.items.indexOf(e).toDouble(),
              e.value,
            ))
        .toList();

    return LineChartBarData(
      isCurved: true,
      color: group.category.toColor(),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: false,
        color: const Color(0x00000000),
      ),
      aboveBarData: BarAreaData(
        show: false,
        color: const Color(0x00000000),
      ),
      spots: spots,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 2,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: leftTitleWidgets,
                showTitles: true,
                interval: 100,
                reservedSize: 60,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Color(0xff4e4965), width: 4),
              left: BorderSide(color: Colors.transparent),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: lineChartBarData,
          minX: 0,
          maxX: (widget.viewModel.dates.length.toDouble()) * 2 - 1,
          maxY: widget.viewModel.maximumExpenseAmount,
          minY: 0,
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  Widget bottomTitleWidgets(double index, TitleMeta meta) {
    if ((index / 2) <= (widget.viewModel.dates.length - 1)) {
      Widget text = Text(
        titles[index ~/ 2],
        style: appTheme.textTheme.caption2.copyWith(
          color: secondaryTextColor,
          fontWeight: FontWeight.w600,
        ),
      );

      return SideTitleWidget(
        meta: meta,
        space: 10,
        child: text,
      );
    }
    return SizedBox();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = appTheme.textTheme.caption2.copyWith(
      color: secondaryTextColor,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: value == widget.viewModel.maximumExpenseAmount ? 10 : 0,
      ),
      child: Text(
        '${value.toStringAsFixed(0)} \$',
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
