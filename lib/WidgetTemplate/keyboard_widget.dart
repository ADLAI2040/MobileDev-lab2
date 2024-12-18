import 'package:flutter/material.dart';

class KeyboardWidget extends StatefulWidget {
  String textInput;
  bool negative;
  final Function(String) onTextInputChanged;

  KeyboardWidget({
    required this.textInput,
    required this.negative,
    required this.onTextInputChanged,
  });
  @override
  State<KeyboardWidget> createState() {
    return _KeyboardState();
  }
}

class _KeyboardState extends State<KeyboardWidget> {
  Widget createKeyboardButton(
      String buttonText, Color buttonColor, Color textColor, bool On) {
    return Container(
      child: ElevatedButton(
        onPressed: On
            ? () {
                inputText(buttonText);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          disabledBackgroundColor: Colors.grey[100],
          shadowColor: Colors.grey[400],
          fixedSize: const Size(107, 76),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.negative == true)
                  createKeyboardButton('+/-', Colors.blue, Colors.white, true)
                else
                  createKeyboardButton('', Colors.black, Colors.black, false),
                createKeyboardButton('CE', Colors.blue, Colors.white, true),
                createKeyboardButton('C', Colors.blue, Colors.white, true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                createKeyboardButton('7', Colors.white, Colors.black, true),
                createKeyboardButton('8', Colors.white, Colors.black, true),
                createKeyboardButton('9', Colors.white, Colors.black, true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                createKeyboardButton('4', Colors.white, Colors.black, true),
                createKeyboardButton('5', Colors.white, Colors.black, true),
                createKeyboardButton('6', Colors.white, Colors.black, true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                createKeyboardButton('1', Colors.white, Colors.black, true),
                createKeyboardButton('2', Colors.white, Colors.black, true),
                createKeyboardButton('3', Colors.white, Colors.black, true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                createKeyboardButton('', Colors.black, Colors.black, false),
                createKeyboardButton('0', Colors.white, Colors.black, true),
                createKeyboardButton('.', Colors.blue, Colors.white, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void inputText(String buttonText) {
    String newText = widget.textInput;

    if (newText.length >= 15 &&
        buttonText != "C" &&
        buttonText != "CE" &&
        buttonText != "+/-") {
      return;
    }

    switch (buttonText) {
      case "CE":
        {
          newText = "0";
        }
        break;
      case "C":
        {
          int subtextInput = 1;
          if (newText.startsWith("-")) {
            subtextInput++;
          }

          if (newText.length > subtextInput) {
            newText = newText.substring(0, newText.length - 1);
          } else {
            newText = "0";
          }
        }
        break;
      case ".":
        {
          if (!newText.contains(".")) {
            newText += buttonText;
          }
        }
        break;
      case "+/-":
        {
          if (newText != "0") {
            if (newText.startsWith("-")) {
              newText = newText.substring(1);
            } else {
              newText = "-" + newText;
            }
          }
        }
        break;
      default:
        {
          if (newText == "0") {
            newText = buttonText;
          } else {
            newText += buttonText;
          }
        }
        break;
    }

    widget.onTextInputChanged(newText);
  }
}
