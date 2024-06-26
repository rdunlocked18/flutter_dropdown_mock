part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeStatesLoaded extends HomeState {
  final List<Place>? states;
  final List<Place>? countries;
  final Place? countrySelection;
  final Place? stateSelection;
  final bool isValid;

  const HomeStatesLoaded({
    this.states,
    this.countries,
    this.countrySelection,
    this.stateSelection,
    this.isValid = false,
  });

  @override
  List<Object?> get props => [
        states,
        countries,
        countrySelection,
        stateSelection,
        isValid,
      ];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
