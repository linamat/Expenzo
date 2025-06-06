import 'package:expenzo/main_screen/models/chart_view_models/bar_chart_item_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_chart_item_group_view_model.freezed.dart';

@freezed
abstract class BarChartItemGroupViewModel with _$BarChartItemGroupViewModel {
  const factory BarChartItemGroupViewModel({
    required List<BarChartItemViewModel> items,
    required DateTime date,
  }) = _BarChartItemGroupViewModel;
}
