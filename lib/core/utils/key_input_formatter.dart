import 'package:flutter/services.dart';

class KeyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Если текст удаляется - возвращаем как есть
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    var text = newValue.text.toUpperCase();
    
    // Удаляем все не-буквенно-цифровые символы, кроме подчеркивания
    text = text.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
    
    // Заменяем пробелы и дефисы на подчеркивания
    text = text.replaceAll(RegExp(r'[\s-]'), '_');
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}