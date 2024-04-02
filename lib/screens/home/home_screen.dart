import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/cubits/home/countries_cubit.dart';
import 'package:flutter_bloc_demo/data/models/countries_model.dart';
import '../../cubits/form_status.dart';
import '../../cubits/home/countries_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
          if (state.formStatus == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.formStatus == FormStatus.error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.statusText),
              ],
            );
          }
          return Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: searchController,
                  onChanged: (v) {
                    context.read<CountriesCubit>().filterSearchResults(v);
                  },
                  decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: List.generate(state.countries.length, (index) {
                    CountryModel countryModel = state.countries[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                      child: ListTile(
                        title: Text(
                          "Country: ${countryModel.name}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text("Capital: ${countryModel.capital}"),
                        leading: Text(countryModel.emoji),
                        trailing: Text(countryModel.currency),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
