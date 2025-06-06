import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/main_screen/models/chart_view_models/bar_chart_item_group_view_model.dart';
import 'package:expenzo/main_screen/models/chart_view_models/bar_chart_view_model.dart';
import 'package:expenzo/theme/app_colors.dart';
import 'package:expenzo/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBarChart extends StatefulWidget {
  final BarChartViewModel viewModel;

  const CustomBarChart({
    required this.viewModel,
    super.key,
  });

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late List<String> titles;
  final double width = 7;

  @override
  void initState() {
    super.initState();

    titles = widget.viewModel.dates
        .map(
          (e) => DateFormat('MMM dd').format(e),
        )
        .toList();

    final items = widget.viewModel.itemGroups
        .map(
          (element) => makeGroupData(
            element,
            widget.viewModel.itemGroups.indexOf(element),
          ),
        )
        .toList();

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  BarChartGroupData makeGroupData(BarChartItemGroupViewModel group, int index) {
    final List<BarChartRodData> barChartGroupItems = <BarChartRodData>[];

    group.items.forEach(
      (element) {
        barChartGroupItems.add(
          BarChartRodData(
            toY: element.value,
            color: element.category.toColor(),
            width: width,
          ),
        );
      },
    );

    return BarChartGroupData(
      barsSpace: 4,
      x: index,
      barRods: barChartGroupItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BarChart(
        BarChartData(
          maxY: widget.viewModel.maximumExpenseAmount,
          barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (_a, _b, _c, _d) => null,
              ),
              touchCallback: (FlTouchEvent event, response) {}),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: makeBottomTitles,
                reservedSize: 42,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: 50,
                getTitlesWidget: leftTitles,
              ),
              drawBelowEverything: false,
              // drawBehindEverything: false,
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: showingBarGroups,
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }

//* The bottom row of days
  Widget makeBottomTitles(
    double index,
    TitleMeta meta,
  ) {
    Widget text = Text(
      titles[index.toInt()],
      style: appTheme.textTheme.caption2.copyWith(
        color: secondaryTextColor,
        fontWeight: FontWeight.w600,
      ),
    );

    return SideTitleWidget(
      meta: meta,
      space: 16, //margin top
      child: text,
    );
  }

//* The right column of prices
  Widget leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Padding(
        padding: EdgeInsets.only(
          top: value == widget.viewModel.maximumExpenseAmount ? 10 : 0,
        ),
        child: Text(
          '${value.toStringAsFixed(0)} \$',
          style: appTheme.textTheme.caption2.copyWith(
            color: secondaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
