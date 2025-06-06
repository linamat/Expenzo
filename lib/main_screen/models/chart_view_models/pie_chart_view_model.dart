import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/main_screen/models/chart_view_models/pie_chart_item_view_model.dart';
import 'package:expenzo/main_screen/models/expense_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pie_chart_view_model.freezed.dart';

@freezed
abstract class PieChartViewModel with _$PieChartViewModel {
  const factory PieChartViewModel({
    required List<PieChartItemViewModel> items,
  }) = _PieChartViewModel;

  const PieChartViewModel._();

  factory PieChartViewModel.fromExpenses(
    List<ExpenseViewModel> expenses,
  ) {
    List<PieChartItemViewModel> pieChartItems = [];

    ExpenseCategory.values.forEach((category) {
      double amount = 0.0;

      expenses.forEach((expense) {
        if (expense.category == category) {
          amount += expense.amount;
        }
      });

      final pieChartItem = PieChartItemViewModel(
        category: category,
        value: amount,
      );

      pieChartItems.add(pieChartItem);
    });

    return PieChartViewModel(
      items: pieChartItems,
    );
  }
}
