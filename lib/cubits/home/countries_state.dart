import 'package:flutter_bloc_demo/data/models/countries_model.dart';
import '../form_status.dart';

class CountriesState {
  final FormStatus formStatus;
  final List<CountryModel> countries;
  final String statusText;

  CountriesState({
    required this.formStatus,
    required this.statusText,
    required this.countries,
  });

  CountriesState copyWith({
    FormStatus? formStatus,
    List<CountryModel>? countries,
    String? statusText,
  }) =>
      CountriesState(
        formStatus: formStatus ?? this.formStatus,
        countries: countries ?? this.countries,
        statusText: statusText ?? this.statusText,
      );
}