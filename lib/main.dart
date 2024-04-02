import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/cubits/home/countries_cubit.dart';
import 'package:flutter_bloc_demo/cubits/pincode/pincode_cubit.dart';
import 'package:flutter_bloc_demo/data/local/storage_repository.dart';
import 'package:flutter_bloc_demo/screens/pincode/pin_code_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  StorageRepository.instance;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PinCodeCubit()),
        BlocProvider(create: (_) => CountriesCubit()..fetchCountries()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const PinCodeScreen(),
    );
  }
}
