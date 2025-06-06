import 'package:expenzo/main_screen/models/expense_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_view_model.freezed.dart';

@freezed
abstract class MainScreenViewModel with _$MainScreenViewModel {
  const factory MainScreenViewModel({
    required List<ExpenseViewModel> expenses,
  }) = _MainScreenViewModel;
}
