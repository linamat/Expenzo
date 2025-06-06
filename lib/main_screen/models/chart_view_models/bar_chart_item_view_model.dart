import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_chart_item_view_model.freezed.dart';

@freezed
abstract class BarChartItemViewModel with _$BarChartItemViewModel {
  const factory BarChartItemViewModel({
    required double value,
    required ExpenseCategory category,
  }) = _BarChartItemViewModel;
}
