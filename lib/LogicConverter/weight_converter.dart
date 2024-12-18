import 'package:flutter/material.dart';
import "../WidgetTemplate/keyboard_widget.dart";
import '../WidgetTemplate/myappbar_widget.dart';
import '../WidgetTemplate/terminal_widget.dart';

class WeightConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Weight(),
    );
  }
}

class Weight extends StatefulWidget {
  @override
  State<Weight> createState() {
    return _WeightState();
  }
}

class _WeightState extends State<Weight> {
  String weigFrom = "0";
  String weigIn = "0";
  String fromScale = "Гр";
  String toScale = "Фунт";
  List<String> weigItems = ["Гр", "Фунт", "Унция"];

  void updateWeigTextFrom(String newValueFrom) {
    setState(() {
      weigFrom = newValueFrom;
      weigIn = convertWeight(double.parse(newValueFrom), fromScale, toScale)
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
      weigIn = convertWeight(double.parse(weigFrom), fromScale, toScale)
          .toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        titleText: "WEIGHT",
      ),
      body: Container(
        child: Column(
          children: [
            TerminalWidget(
              textFrom: weigFrom,
              textIn: weigIn,
              items: weigItems,
              defaultScaleFrom: fromScale,
              defaultScaleIn: toScale,
              onScaleChanged: updateScale,
            ),
            KeyboardWidget(
              textInput: weigFrom,
              negative: false,
              onTextInputChanged: updateWeigTextFrom,
            ),
          ],
        ),
      ),
    );
  }

  double convertWeight(double value, String fromScale, String toScale) {
    double weightGr;

    switch (fromScale) {
      case "Гр":
        weightGr = value;
        break;
      case "Фунт":
        weightGr = value * 453.59237;
        break;
      case "Унция":
        weightGr = value * 28.349523125;
        break;
      default:
        throw Exception("Unknown scale: $fromScale");
    }

    switch (toScale) {
      case "Гр":
        return weightGr;
      case "Фунт":
        return weightGr / 453.59237;
      case "Унция":
        return weightGr / 28.349523125;
      default:
        throw Exception("Unknown scale: $toScale");
    }
  }
}
