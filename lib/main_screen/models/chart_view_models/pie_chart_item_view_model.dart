import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pie_chart_item_view_model.freezed.dart';

@freezed
abstract class PieChartItemViewModel with _$PieChartItemViewModel {
  const factory PieChartItemViewModel({
    required double value,
    required ExpenseCategory category,
  }) = _PieChartViewModelItemViewModel;
}
