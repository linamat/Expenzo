part of 'main_screen_bloc.dart';

@freezed
abstract class MainScreenState with _$MainScreenState {
  const factory MainScreenState.initial({
    required MainScreenViewModel mainScreenViewModel,
  }) = MainScreenInitialState;

  const factory MainScreenState.loaded({
    required MainScreenViewModel mainScreenViewModel,
  }) = MainScreenLoadedState;
}
