import 'package:flutter/services.dart';

class ArabicNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    bool containsArabicNumber = false;
    // Check if the new text contains Arabic numbers
    for (int i = 0; i < newText.length; i++) {
      if (newText.codeUnitAt(i) >= 0x0660 && newText.codeUnitAt(i) <= 0x0669) {
        containsArabicNumber = true;
        break;
      }
    }
    // Convert Arabic numbers to English numbers
    if (containsArabicNumber) {
      String englishNumbers = '';
      for (int i = 0; i < newText.length; i++) {
        int codeUnit = newText.codeUnitAt(i);
        if (codeUnit >= 0x0660 && codeUnit <= 0x0669) {
          englishNumbers += String.fromCharCode(codeUnit - 0x0630);
        } else {
          englishNumbers += String.fromCharCode(codeUnit);
        }
      }
      newText = englishNumbers;
    }
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
      composing: TextRange.empty,
    );
  }
}
