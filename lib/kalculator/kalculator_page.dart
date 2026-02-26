import 'package:flutter/material.dart';
import 'package:kalculator/services/kalculator_button.dart';
import 'package:kalculator/services/kalculator_service.dart';
import 'package:provider/provider.dart';

class KalculatorPage extends StatelessWidget {
  const KalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KalculatorService(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<KalculatorService>(
                  builder: (_, controller, _) => Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(24),
                    child: Text(controller.display, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Consumer<KalculatorService>(
      builder: (_, controller, _) => Column(
        children: [
          Row(
            children: [
              KalculatorButton(text: 'AC', onTap: controller.clear),
              KalculatorButton(text: '+/-', onTap: controller.toggleSign),
              KalculatorButton(text: '%', onTap: controller.percent),
              KalculatorButton(text: '÷', onTap: () => controller.inputOperator('÷')),
            ],
          ),
          Row(
            children: [
              KalculatorButton(text: '7', onTap: () => controller.inputNumber('7')),
              KalculatorButton(text: '8', onTap: () => controller.inputNumber('8')),
              KalculatorButton(text: '9', onTap: () => controller.inputNumber('9')),
              KalculatorButton(text: '×', onTap: () => controller.inputOperator('×')),
            ],
          ),
          Row(
            children: [
              KalculatorButton(text: '4', onTap: () => controller.inputNumber('4')),
              KalculatorButton(text: '5', onTap: () => controller.inputNumber('5')),
              KalculatorButton(text: '6', onTap: () => controller.inputNumber('6')),
              KalculatorButton(text: '-', onTap: () => controller.inputOperator('-')),
            ],
          ),
          Row(
            children: [
              KalculatorButton(text: '1', onTap: () => controller.inputNumber('1')),
              KalculatorButton(text: '2', onTap: () => controller.inputNumber('2')),
              KalculatorButton(text: '3', onTap: () => controller.inputNumber('3')),
              KalculatorButton(text: '+', onTap: () => controller.inputOperator('+')),
            ],
          ),
          Row(
            children: [
              KalculatorButton(text: '0', onTap: () => controller.inputNumber('0')),
              KalculatorButton(text: '.', onTap: controller.inputDecimal),
              KalculatorButton(text: '⌫', onTap: controller.backspace),
              KalculatorButton(text: '=', onTap: controller.equals),
            ],
          ),
        ],
      ),
    );
  }
}
