import 'package:expenzo/main_screen/models/chart_view_models/pie_chart_view_model.dart';
import 'package:expenzo/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expenzo/main_screen/enums/expense_category.dart';

import 'indicator.dart';

class CustomPieChart extends StatefulWidget {
  final PieChartViewModel pieChartViewModel;

  const CustomPieChart({
    required this.pieChartViewModel,
    super.key,
  });

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.pieChartViewModel.items.length,
              (index) {
                final pieChartItemViewModel =
                    widget.pieChartViewModel.items[index];

                return Indicator(
                  color: pieChartItemViewModel.category.toColor(),
                  text: pieChartItemViewModel.category.name,
                  isSquare: true,
                );
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      widget.pieChartViewModel.items.length,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

        final pieChartViewModel = widget.pieChartViewModel.items[i];

        return PieChartSectionData(
          color: pieChartViewModel.category.toColor(),
          value: pieChartViewModel.value,
          title: '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: secondaryTextColor,
            shadows: shadows,
          ),
        );
      },
    );
  }
}
