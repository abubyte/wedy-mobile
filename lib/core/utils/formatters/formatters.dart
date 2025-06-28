import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wedy/core/utils/utils.dart';

abstract class Formatters extends Utils {}

class PhoneNumberFormatter extends Formatters {
  static final inputFormatter = MaskTextInputFormatter(mask: '+998 (##) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  static format(String value) {
    return '';
  }

  static parse(String value) {
    return '';
  }
}

class PriceFormatter extends Formatters {
  static final inputFormatter = MaskTextInputFormatter(mask: '### ### ### so\'m', filter: {"#": RegExp(r'[0-9]')});
}