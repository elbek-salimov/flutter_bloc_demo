import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/cubits/home/countries_state.dart';
import 'package:flutter_bloc_demo/data/models/countries_model.dart';

import '../../data/network/api_provider.dart';
import '../../data/network/network_response.dart';
import '../form_status.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit()
      : super(
    CountriesState(
      formStatus: FormStatus.pure,
      statusText: "",
      countries: [],
    ),
  ) {
    //fetchCurrencies();
  }

  List<CountryModel> allCountries = [];

  fetchCountries() async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    NetworkResponse response = await ApiProvider.getCountries();
    if (response.errorText.isEmpty) {
      allCountries = response.data as List<CountryModel>;
      emit(
        state.copyWith(
          countries: allCountries,
          formStatus: FormStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(
        statusText: response.errorText,
        formStatus: FormStatus.error,
      ));
    }
  }

  void filterSearchResults(String query) {
    List<CountryModel> searchResults = allCountries
        .where((country) => country.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(countries: searchResults));
  }

}