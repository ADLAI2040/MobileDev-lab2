import 'package:flutter/material.dart';
import "../WidgetTemplate/keyboard_widget.dart";
import '../WidgetTemplate/myappbar_widget.dart';
import '../WidgetTemplate/terminal_widget.dart';

class LenghtConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lenght(),
    );
  }
}

class Lenght extends StatefulWidget {
  @override
  State<Lenght> createState() {
    return _LenghtState();
  }
}

class _LenghtState extends State<Lenght> {
  String lenFrom = "0";
  String lenIn = "0";
  String fromScale = "См";
  String toScale = "Ярд";
  List<String> lenItems = ["См", "Ярд", "Дюйм", "Футы"];

  void updateLenTextFrom(String newValueFrom) {
    setState(() {
      lenFrom = newValueFrom;
      lenIn = convertLenght(double.parse(newValueFrom), fromScale, toScale)
          .toString();
    });
  }

  void updateScale(String scale, bool isFromScale) {
    setState(() {
      if (isFromScale == true) {
        fromScale = scale;
      } else {
        toScale = scale;
      }
      lenIn = convertLenght(double.parse(lenFrom), fromScale, toScale)
          .toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        titleText: "LENGHT",
      ),
      body: Container(
        child: Column(
          children: [
            TerminalWidget(
              textFrom: lenFrom,
              textIn: lenIn,
              items: lenItems,
              defaultScaleFrom: fromScale,
              defaultScaleIn: toScale,
              onScaleChanged: updateScale,
            ),
            KeyboardWidget(
              textInput: lenFrom,
              negative: false,
              onTextInputChanged: updateLenTextFrom,
            ),
          ],
        ),
      ),
    );
  }

  double convertLenght(double value, String fromScale, String toScale) {
    double lenghtCm;

    switch (fromScale) {
      case "См":
        lenghtCm = value;
        break;
      case "Ярд":
        lenghtCm = value * 91.44;
        break;
      case "Дюйм":
        lenghtCm = value * 2.54;
        break;
      case "Футы":
        lenghtCm = value * 30.48;
        break;
      default:
        throw Exception("Unknown scale: $fromScale");
    }

    switch (toScale) {
      case "См":
        return lenghtCm;
      case "Ярд":
        return lenghtCm / 91.44;
      case "Дюйм":
        return lenghtCm / 2.54;
      case "Футы":
        return lenghtCm / 30.48;
      default:
        throw Exception("Unknown scale: $toScale");
    }
  }
}
