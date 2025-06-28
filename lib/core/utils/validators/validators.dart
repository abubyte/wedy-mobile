import 'package:wedy/core/utils/utils.dart';

abstract class Validators extends Utils {}

class LoginValidator extends Validators {
  static String? validator(String? value) {
    final regex = RegExp(r'^(?:\+998\d{9}|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$');
    return regex.hasMatch(value ?? '') ? null : "Login telefon raqam yoki email bo'lishi kerak!";
  }
}

class PasswordValidator extends Validators {
  static String? validator(String? value) {
    final minLengthRegex = RegExp(r'^.{8,}$');
    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');
    final hasSymbol = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (!minLengthRegex.hasMatch(value ?? '')) {
      return "Parol kamida 8 ta belgidan iborat bo'lishi kerak!";
    } else if (!hasUppercase.hasMatch(value ?? '')) {
      return "Parolda kamida 1 ta katta harf bo'lishi kerak!";
    } else if (!hasLowercase.hasMatch(value ?? '')) {
      return "Parolda kamida 1 ta kichik harf bo'lishi kerak!";
    } else if (!hasDigit.hasMatch(value ?? '')) {
      return "Parolda kamida 1 ta raqam bo'lishi kerak!";
    } else if (!hasSymbol.hasMatch(value ?? '')) {
      return "Parolda kamida 1 ta maxsus belgi bo'lishi kerak!";
    }

    return null;
  }
}

class ConfirmPasswordValidator extends Validators {
  static String? validator(String? value1, String value2) {
    if (value1 == value2) return null;
    return "Parollar mos kelishi kerak";
  }
}

class TextValidator extends Validators {
  static String? validator(String? value) {
    if (value != null && value.isNotEmpty) return null;
    return "Maydon bo'sh bo'lishi mumkin emas";
  }
}

class FullNameValidator extends Validators {
  static String? validator(String? value) {
    if (value != null && (value.split(' ').length == 2)) {
      return null;
    }

    return "Ism va familya kiritilishi shart!";
  }
}
