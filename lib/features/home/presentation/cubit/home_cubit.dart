import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit({required this.homeRepository}) : super(HomeInitial()) {
    loadCountries();
  }
  // Save State values
  List<Place> countries = [];
  List<Place> states = [];
  Place? selectedCountry;
  Place? selectedState;

  /// [loadCountries]
  /// Loads the Countries from calling Repository.remoteDatasource
  /// retruns [List<Place>] as countries and stores in buffer
  Future<void> loadCountries() async {
    emit(HomeLoading());
    countries = [];
    var countriesOrFailure = await homeRepository.getCountries();
    countriesOrFailure.fold(
      (failure) {
        //
        emit(HomeError(failure.message ?? ''));
      },
      (result) {
        //
        countries = result;
        emit(HomeStatesLoaded(states: states, countries: countries));
      },
    );
  }

  /// [loadStates]
  /// Loads the state for specific country[id]
  /// [id] currently selected CountryId [Place.id]
  Future<void> loadSates(int id) async {
    var statesOrFailure = await homeRepository.getStates(placeId: id);
    statesOrFailure.fold(
      (failure) {
        //
        emit(HomeError(failure.message ?? ''));
      },
      (result) {
        //
        states = result;
        emit(HomeStatesLoaded(
            states: states,
            countries: countries,
            countrySelection: selectedCountry));
      },
    );
  }

  /// On Country Dropdown Value selected
  /// selects [Place] as Current Selection
  void selectCountry(Place? country) {
    selectedCountry = country;
    states = [];
    selectedState = null;

    emit(HomeStatesLoaded(
        states: states,
        countries: countries,
        countrySelection: selectedCountry,
        stateSelection: selectedState));

    loadSates(country?.id ?? 0);
  }

  /// On State Dropdown Value selected
  /// selects [Place] as Current State Selection
  void selectState(Place? selection) {
    selectedState = selection;
    emit(HomeStatesLoaded(
        states: states,
        countries: countries,
        countrySelection: selectedCountry,
        stateSelection: selection));
  }

  /// Submit Button Callback
  /// validates form and returns [isValid]
  /// isValid then ? listener, else : stay on same State
  void submitClicked(GlobalKey<FormState> formKey) {
    emit(
      HomeStatesLoaded(
        states: states,
        countries: countries,
        countrySelection: selectedCountry,
        stateSelection: selectedState,
        isValid: formKey.currentState?.validate() ?? false,
      ),
    );
  }
}
