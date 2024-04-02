import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/data/local/storage_repository.dart';
import 'package:flutter_bloc_demo/screens/pincode/pin_code_reenter.dart';

import '../../screens/home/home_screen.dart';

class PinCodeCubit extends Cubit<String> {
  PinCodeCubit() : super('');

  Future<void> savePin(String pin, BuildContext context) async {
    debugPrint('PINNN: $pin');
    String enterPin = StorageRepository.getString(key: 'pin');
    if (pin.length == 4 && enterPin.isEmpty) {
      await StorageRepository.setString(key: 'pin', value: pin);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return const PinCodeReenterScreen();
          }));
    } if(pin.length == 4 && pin == enterPin) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
    }
  }

  void checkPin(String pin, BuildContext context) {
    debugPrint('PINNN2: $pin');
    if (pin.length == 4) {
      String firstPin = StorageRepository.getString(key: 'pin');
      emit(firstPin);
      debugPrint("FIRSTPIN:$firstPin");
      if(firstPin == pin){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
      }
    } else {
      emit(pin);
    }
  }

}
