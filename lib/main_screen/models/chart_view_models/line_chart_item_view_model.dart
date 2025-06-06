import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_chart_item_view_model.freezed.dart';

@freezed
abstract class LineChartItemViewModel with _$LineChartItemViewModel {
  const factory LineChartItemViewModel({
    required double value,
    required DateTime date,
  }) = _LineChartItemViewModel;
}
