import 'package:flutter/material.dart';
import 'LogicConverter/currency_converter.dart';
import 'LogicConverter/weight_converter.dart';
import 'LogicConverter/lenght_converter.dart';
import 'LogicConverter/temperature_converter.dart';
import 'LogicConverter/volume_converter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ConverterHome(),
        routes: <String, WidgetBuilder>{
          '/Валюта': (context) => CurrencyConverter(),
          '/Масса': (context) => WeightConverter(),
          '/Длина': (context) => LenghtConverter(),
          '/Температура': (context) => TemperatureConverter(),
          '/Объём': (context) => VolumeConverter(),
        });
  }
}

class ConverterHome extends StatelessWidget {
  Widget createNavButton(String buttonText, Color buttonColor, Color textColor,
      BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/$buttonText');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.all(10.0),
          minimumSize: Size(280.0, 80.0),
          shape: StadiumBorder(),
        ),
        child: Text(buttonText,
            style: TextStyle(
              fontSize: 40,
              color: textColor,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'CONVERTER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createNavButton("Валюта", Colors.blue, Colors.white, context),
              createNavButton("Масса", Colors.blue, Colors.white, context),
              createNavButton("Длина", Colors.blue, Colors.white, context),
              createNavButton("Температура", Colors.blue, Colors.white, context),
              createNavButton("Объём", Colors.blue, Colors.white, context),
            ],
          ),
        ),
      ),
    );
  }
}
