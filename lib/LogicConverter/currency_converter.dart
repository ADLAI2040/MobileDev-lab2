import 'package:flutter/material.dart';
import "../WidgetTemplate/keyboard_widget.dart";
import '../WidgetTemplate/myappbar_widget.dart';
import '../WidgetTemplate/terminal_widget.dart';

class CurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Currency(),
    );
  }
}

class Currency extends StatefulWidget {
  @override
  State<Currency> createState() {
    return _CurrencyState();
  }
}

class _CurrencyState extends State<Currency> {
  String currFrom = "0";
  String currIn = "0";
  String fromScale = "RUB";
  String toScale = "USD";
  List<String> currItems = ["RUB", "USD", "EUR"];

  void updateCurrTextFrom(String newValueFrom) {
    setState(() {
      currFrom = newValueFrom;
      currIn = convertCurrency(double.parse(newValueFrom), fromScale, toScale)
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
      currIn = convertCurrency(double.parse(currFrom), fromScale, toScale)
          .toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        titleText: "CURRENCY",
      ),
      body: Container(
        child: Column(
          children: [
            TerminalWidget(
              textFrom: currFrom,
              textIn: currIn,
              items: currItems,
              defaultScaleFrom: fromScale,
              defaultScaleIn: toScale,
              onScaleChanged: updateScale,
            ),
            KeyboardWidget(
              textInput: currFrom,
              negative: false,
              onTextInputChanged: updateCurrTextFrom,
            ),
          ],
        ),
      ),
    );
  }

  double convertCurrency(double value, String fromScale, String toScale) {
    double rub;

    switch (fromScale) {
      case "RUB":
        rub = value;
        break;
      case "USD":
        rub = value * 100;
        break;
      case "EUR":
        rub = value * 105.5;
        break;
      default:
        throw Exception("Unknown scale: $fromScale");
    }

    switch (toScale) {
      case "RUB":
        return rub;
      case "USD":
        return rub / 100;
      case "EUR":
        return rub / 105.5;
      default:
        throw Exception("Unknown scale: $toScale");
    }
  }
}
