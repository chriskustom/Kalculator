import 'package:flutter/material.dart';

class KalculatorService extends ChangeNotifier {
  String _display = '0';
  double? _previousValue;
  String? _operator;
  double? _lastOperand; // for repeated equals
  bool _shouldResetInput = false;
  bool _evaluated = false;

  String get display => _display;

  void inputNumber(String number) {
    if (_evaluated) {
      // Start completely new calculation after equals
      _display = number;
      _previousValue = null;
      _operator = null;
      _lastOperand = null;
      _evaluated = false;
      _shouldResetInput = false;
    } else if (_shouldResetInput) {
      _display = number;
      _shouldResetInput = false;
    } else {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    }
    notifyListeners();
  }

  void inputDecimal() {
    if (_shouldResetInput) {
      _display = '0.';
      _shouldResetInput = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
    notifyListeners();
  }

  void inputOperator(String op) {
    if (_operator != null && !_shouldResetInput) {
      _evaluate();
    } else {
      _previousValue = double.parse(_display);
    }

    _operator = op;
    _shouldResetInput = true;
    notifyListeners();
  }

  void equals() {
    if (_operator == null) return;

    if (!_shouldResetInput) {
      _lastOperand = double.parse(_display);
    }
    _evaluate();
    notifyListeners();
  }

  void clear() {
    _display = '0';
    _previousValue = null;
    _operator = null;
    _lastOperand = null;
    _shouldResetInput = false;
    notifyListeners();
  }

  void backspace() {
    if (_shouldResetInput) return;

    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
    }

    notifyListeners();
  }

  void toggleSign() {
    if (_display == '0') return;

    if (_display.startsWith('-')) {
      _display = _display.substring(1);
    } else {
      _display = '-$_display';
    }

    notifyListeners();
  }

  void percent() {
    double value = double.parse(_display);
    value = value / 100;

    _display = _format(value);
    notifyListeners();
  }

  void _evaluate() {
    if (_previousValue == null || _operator == null) return;

    double current = _shouldResetInput && _lastOperand != null ? _lastOperand! : double.parse(_display);

    switch (_operator) {
      case '+':
        _previousValue = _previousValue! + current;
        break;
      case '-':
        _previousValue = _previousValue! - current;
        break;
      case '×':
        _previousValue = _previousValue! * current;
        break;
      case '÷':
        if (current == 0) {
          _display = 'Error';
          _previousValue = null;
          _operator = null;
          return;
        }
        _previousValue = _previousValue! / current;
        break;
    }
    _evaluated = true;
    _display = _format(_previousValue!);
    _shouldResetInput = true;
  }

  String _format(double value) {
    return value.toStringAsPrecision(12).replaceAll(RegExp(r'\.?0+$'), '');
  }
}
