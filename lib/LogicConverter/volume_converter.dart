import 'package:flutter/material.dart';
import "../WidgetTemplate/keyboard_widget.dart";
import '../WidgetTemplate/myappbar_widget.dart';
import '../WidgetTemplate/terminal_widget.dart';

class VolumeConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Volume(),
    );
  }
}

class Volume extends StatefulWidget {
  @override
  State<Volume> createState() {
    return _VolumeState();
  }
}

class _VolumeState extends State<Volume> {
  String volFrom = "0";
  String volIn = "0";
  String fromScale = "Литр";
  String toScale = "Пинта";
  List<String> volItems = ["Литр", "Пинта", "Галлон"];

  void updateLenTextFrom(String newValueFrom) {
    setState(() {
      volFrom = newValueFrom;
      volIn = convertVolume(double.parse(newValueFrom), fromScale, toScale)
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
      volIn = convertVolume(double.parse(volFrom), fromScale, toScale)
          .toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(
        titleText: "VOLUME",
      ),
      body: Container(
        child: Column(
          children: [
            TerminalWidget(
              textFrom: volFrom,
              textIn: volIn,
              items: volItems,
              defaultScaleFrom: fromScale,
              defaultScaleIn: toScale,
              onScaleChanged: updateScale,
            ),
            KeyboardWidget(
              textInput: volFrom,
              negative: false,
              onTextInputChanged: updateLenTextFrom,
            ),
          ],
        ),
      ),
    );
  }

  double convertVolume(double value, String fromScale, String toScale) {
    double volumelitr;

    switch (fromScale) {
      case "Литр":
        volumelitr = value;
        break;
      case "Пинта":
        volumelitr = value * 0.568;
        break;
      case "Галлон":
        volumelitr = value * 4.55;
        break;
      default:
        throw Exception("Unknown scale: $fromScale");
    }

    switch (toScale) {
      case "Литр":
        return volumelitr;
      case "Пинта":
        return volumelitr / 0.568;
      case "Галлон":
        return volumelitr / 4.55;
      default:
        throw Exception("Unknown scale: $toScale");
    }
  }
}
