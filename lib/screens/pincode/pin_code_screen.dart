import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/cubits/pincode/pincode_cubit.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';

class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCorrect = true;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Set up PIN',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text('Enter your passcode'),
            const SizedBox(height: 60),
            Expanded(
              child: PinCodeWidget(
                filledIndicatorColor: isCorrect == true ? Colors.blue : Colors.red,
                numbersStyle:
                    const TextStyle(color: Colors.white, fontSize: 22),
                minPinLength: 4,
                maxPinLength: 4,
                onChangedPin: (pin) {
                  // check the PIN length and check different PINs with 4,5.. length.
                },
                onEnter: (pin, _) {
                  // callback user pressed enter
                  context.read<PinCodeCubit>().savePin(pin, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
