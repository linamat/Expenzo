import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/main_screen/models/chart_view_models/bar_chart_item_group_view_model.dart';
import 'package:expenzo/main_screen/models/chart_view_models/bar_chart_item_view_model.dart';
import 'package:expenzo/main_screen/models/expense_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_chart_view_model.freezed.dart';

@freezed
abstract class BarChartViewModel with _$BarChartViewModel {
  const factory BarChartViewModel({
    required List<BarChartItemGroupViewModel> itemGroups,
    required List<DateTime> dates,
    required double maximumExpenseAmount,
  }) = _BarChartViewModel;

  const BarChartViewModel._();

  factory BarChartViewModel.fromExpenses(List<ExpenseViewModel> expenses) {
    final List<BarChartItemGroupViewModel> dateItemGroups = [];
    final List<DateTime> dates = [];
    double maximumExpenseAmount = 0.0;

    expenses.forEach(
      (expense) {
        if (!dates.contains(expense.date)) {
          dates.add(expense.date);
        }
      },
    );

    dates.forEach(
      (date) {
        final List<BarChartItemViewModel> groupItems = [];

        expenses.forEach((expense) {
          if (expense.date == date) {
            final groupItem = BarChartItemViewModel(
              value: expense.amount,
              category: expense.category,
            );

            groupItems.add(groupItem);
          }
        });

        dateItemGroups.add(
          BarChartItemGroupViewModel(
            date: date,
            items: groupItems,
          ),
        );
      },
    );

    final List<BarChartItemGroupViewModel> itemGroups = [];

    dateItemGroups.forEach((group) {
      final List<BarChartItemViewModel> groupItems = [];

      ExpenseCategory.values.forEach((category) {
        double categoryAmount = 0.0;

        group.items.forEach((item) {
          if (item.category == category) {
            categoryAmount += item.value;
          }
        });

        if (categoryAmount > maximumExpenseAmount) {
          maximumExpenseAmount = categoryAmount;
        }

        groupItems.add(
          BarChartItemViewModel(
            value: categoryAmount,
            category: category,
          ),
        );
      });

      itemGroups.add(
        BarChartItemGroupViewModel(
          items: groupItems,
          date: group.date,
        ),
      );
    });

    return BarChartViewModel(
      itemGroups: itemGroups,
      dates: dates,
      maximumExpenseAmount: maximumExpenseAmount,
    );
  }
}
