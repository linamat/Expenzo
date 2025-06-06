import 'package:bloc/bloc.dart';
import 'package:expenzo/main_screen/enums/expense_category.dart';
import 'package:expenzo/main_screen/enums/filter_param.dart';
import 'package:expenzo/main_screen/models/expense_view_model.dart';
import 'package:expenzo/main_screen/models/main_screen_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jiffy/jiffy.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';
part 'main_screen_bloc.freezed.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  var allExpenses = <ExpenseViewModel>[];

  MainScreenBloc()
      : super(
          MainScreenState.initial(
            mainScreenViewModel: MainScreenViewModel(expenses: []),
          ),
        ) {
    on<AddExpenseEvent>(_handleAddExpenseEvent);
    on<RemoveExpenseEvent>(_handleRemoveExpenseEvent);
    on<FilterExpenseByCategoryEvent>(_handleFilterExpenseByCategoryEvent);
    on<FilterExpenseByDateEvent>(_handleFilterExpenseByDateEvent);
  }

  void _handleAddExpenseEvent(
    AddExpenseEvent event,
    Emitter emit,
  ) {
    List<ExpenseViewModel> expenses = [...state.mainScreenViewModel.expenses];

    expenses.add(event.expenseViewModel);

    allExpenses.add(event.expenseViewModel);

    emit(
      MainScreenLoadedState(
        mainScreenViewModel: MainScreenViewModel(
          expenses: expenses,
        ),
      ),
    );
  }

  void _handleRemoveExpenseEvent(
    RemoveExpenseEvent event,
    Emitter<MainScreenState> emit,
  ) {
    var expenses = <ExpenseViewModel>[...state.mainScreenViewModel.expenses];

    expenses.removeWhere(
      (element) => element.id == event.id,
    );

    allExpenses.removeWhere(
      (element) => element.id == event.id,
    );

    emit(
      MainScreenState.loaded(
        mainScreenViewModel: MainScreenViewModel(
          expenses: expenses,
        ),
      ),
    );
  }

  void _handleFilterExpenseByCategoryEvent(
    FilterExpenseByCategoryEvent event,
    Emitter<MainScreenState> emit,
  ) {
    var expenses = <ExpenseViewModel>[];

    allExpenses.forEach(
      (element) {
        if (element.category == event.expenseCategory) {
          expenses.add(element);
        }
      },
    );

    emit(
      MainScreenState.loaded(
        mainScreenViewModel: MainScreenViewModel(
          expenses: expenses,
        ),
      ),
    );
  }

  void _handleFilterExpenseByDateEvent(
    FilterExpenseByDateEvent event,
    Emitter<MainScreenState> emit,
  ) {
    var expenses = <ExpenseViewModel>[];
    final currentDate = DateTime.now();

    if (event.filterParam == FilterParam.today) {
      allExpenses.forEach(
        (element) {
          if (element.date.day == currentDate.day &&
              element.date.month == currentDate.month &&
              element.date.year == currentDate.year) {
            expenses.add(element);
          }
        },
      );
    } else if (event.filterParam == FilterParam.thisWeek) {
      allExpenses.forEach(
        (element) {
          final currentWeekNumber =
              Jiffy.parse(currentDate.toString()).weekOfYear;
          final expenseWeekNumber =
              Jiffy.parse(element.date.toString()).weekOfYear;

          final checkIfInThisWeek = currentWeekNumber == expenseWeekNumber;
          if (checkIfInThisWeek && element.date.year == currentDate.year) {
            expenses.add(element);
          }
        },
      );
    } else {
      expenses.addAll(allExpenses);
    }

    emit(
      MainScreenState.loaded(
        mainScreenViewModel: MainScreenViewModel(
          expenses: expenses,
        ),
      ),
    );
  }
}
