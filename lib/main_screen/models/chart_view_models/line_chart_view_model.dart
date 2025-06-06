import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/main_screen/models/chart_view_models/line_chart_item_group_view_model.dart';
import 'package:expenzo/main_screen/models/chart_view_models/line_chart_item_view_model.dart';
import 'package:expenzo/main_screen/models/expense_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_chart_view_model.freezed.dart';

@freezed
abstract class LineChartViewModel with _$LineChartViewModel {
  const factory LineChartViewModel({
    required List<LineChartItemGroupViewModel> itemGroups,
    required List<DateTime> dates,
    required double maximumExpenseAmount,
  }) = _LineChartViewModel;

  const LineChartViewModel._();

  factory LineChartViewModel.fromExpenses(List<ExpenseViewModel> expenses) {
    final List<LineChartItemGroupViewModel> categoryItemGroups = [];
    double maximumExpenseAmount = 0.0;

    ExpenseCategory.values.forEach(
      (category) {
        final List<LineChartItemViewModel> groupItems = [];

        expenses.forEach(
          (expense) {
            if (expense.category == category) {
              final groupItem = LineChartItemViewModel(
                value: expense.amount,
                date: expense.date,
              );

              groupItems.add(groupItem);
            }

            if (expense.amount > maximumExpenseAmount) {
              maximumExpenseAmount = expense.amount;
            }
          },
        );

        categoryItemGroups.add(
          LineChartItemGroupViewModel(
            category: category,
            items: groupItems,
          ),
        );
      },
    );

    final List<DateTime> dates = [];
    expenses.forEach(
      (expense) {
        if (!dates.contains(expense.date)) {
          dates.add(expense.date);
        }
      },
    );

    return LineChartViewModel(
      itemGroups: categoryItemGroups,
      dates: dates,
      maximumExpenseAmount: maximumExpenseAmount,
    );
  }
}
