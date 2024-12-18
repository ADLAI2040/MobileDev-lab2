import 'package:flutter/material.dart';
import '../WidgetTemplate/myappbar_widget.dart';
import '../WidgetTemplate/keyboard_widget.dart';
import '../WidgetTemplate/terminal_widget.dart';

class TemperatureConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Temperature(),
    );
  }
}

class Temperature extends StatefulWidget {
  @override
  State<Temperature> createState() {
    return _TemperatureState();
  }
}

class _TemperatureState extends State<Temperature> {
  String tempFrom = "0";
  String tempIn = "0";
  String fromScale = "шкала Цельсия";
  String toScale = "шкала Кельвина";
  List<String> tempItems = [
    "шкала Кельвина",
    "шкала Цельсия",
    "шкала Фаренгейта"
  ];

  void updateTempTextFrom(String newValueFrom) {
    setState(() {
      tempFrom = newValueFrom;
      tempIn =
          convertTemperature(double.parse(newValueFrom), fromScale, toScale)
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
      tempIn = convertTemperature(double.parse(tempFrom), fromScale, toScale)
          .toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        titleText: "TEMPERATURE",
      ),
      body: Container(
        child: Column(
          children: [
            TerminalWidget(
              textFrom: tempFrom,
              textIn: tempIn,
              items: tempItems,
              defaultScaleFrom: fromScale,
              defaultScaleIn: toScale,
              onScaleChanged: updateScale,
            ),
            KeyboardWidget(
              textInput: tempFrom,
              negative: true,
              onTextInputChanged: updateTempTextFrom,
            )
          ],
        ),
      ),
    );
  }

  double convertTemperature(double value, String fromScale, String toScale) {
    double kelvinValue;

    switch (fromScale) {
      case "шкала Кельвина":
        kelvinValue = value;
        break;
      case "шкала Цельсия":
        kelvinValue = value + 273.15;
        break;
      case "шкала Фаренгейта":
        kelvinValue = 5 / 9 * (value + 273.15) - 32;
        break;
      default:
        throw Exception("Unknown scale: $fromScale");
    }

    switch (toScale) {
      case "шкала Кельвина":
        return kelvinValue;
      case "шкала Цельсия":
        return kelvinValue - 273.15;
      case "шкала Фаренгейта":
        return 9 / 5 * (kelvinValue - 273.15) + 32;
      default:
        throw Exception("Unknown scale: $toScale");
    }
  }
}
