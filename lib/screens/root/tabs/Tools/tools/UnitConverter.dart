import 'package:flutter/material.dart';

class Unit {
  late String title;
  late Map units;

  Unit(this.title, this.units);
}

var units = [
  Unit("Length", {
    "centimeters": 1,
    "meters": 100,
    "kilometers": 100000,
    "inches": 2.54,
    "feet": 30.48,
    "yards": 91.44,
    "miles": 160934.4,
  }),
  Unit("Area", {
    "Acres": 6272640,
    "Hectares": 15500031,
    "Square Metres": 1550,
    "Square Kilometres": 1550003100,
    "Square Inches": 1,
    "Square Feet": 144,
  }),
  Unit("Volume", {
    "Millilitres": 1,
    "Litres": 1000,
    "Cubic Centimetres": 1,
    "Cubic Metres": 1000000,
    "Cubic Inches": 16.387064,
    "Cubic Feet": 28316.846592,
    "Cups": 236.5882365,
    "Fluid Ounces": 29.57352965,
    "Gallons": 3785.411784,
    "Teaspoons": 4.92892,
    "Tablespoons": 14.7868,
    "Pints": 473.176475,
  }),
  Unit("Mass", {
    "Grams": 1,
    "Kilograms": 1000,
    "Ounces": 28.3495,
    "Pounds": 453.592,
    "Metric Tons": 1000000,
    "Carats": 0.2,
  }),
  Unit("Speed", {
    "m/s": 1,
    "km/h": 1000,
    "mi/h": 1609.344,
    "knots": 0.5144444444,
  }),
  Unit("Temperature", {
    "Celsius": 1,
    "Fahrenheit": 1000,
    "Kelvin": 1609.344,
  }),
];
/*
*/

class UnitConverterPage extends StatelessWidget {
  const UnitConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unit Converter")),
      body: Column(children: [
        
      ]),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverters/AreaConverter.dart';
// import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverters/LengthConverter.dart';
// import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverters/MassConverter.dart';
// import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverters/SpeedConverter.dart';
// import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverters/TemperatureConverter.dart';
// import 'package:mathx_android/screens/root/tabs/Tools/tools/UnitConverters/VolumeConverter.dart';

// class Unit {
//   late String title;
//   late IconData icon;
//   late Widget page;

//   Unit(this.title, this.icon, this.page);
// }

// var units = [
//   Unit("Length", Icons.straighten, const LengthConverterPage()),
//   Unit("Area", Icons.crop_square, const AreaConverterPage()),
//   Unit("Volume", Icons.place, const VolumeConverterPage()),
//   Unit("Mass", Icons.scale, const MassConverterPage()),
//   Unit("Speed", Icons.speed, const SpeedConverterPage()),
//   Unit("Temperature", Icons.thermostat, const TemperatureConverterPage()),
// ];

// class UnitConverterPage extends StatelessWidget {
//   const UnitConverterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Unit Converter")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//             itemCount: units.length,
//             itemBuilder: (BuildContext buildContext, int index) {
//               return ListTile(
//                 title: Text(units[index].title),
//                 leading: Icon(units[index].icon),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => units[index].page));
//                 },
//               );
//             }),
//       ),
//     );
//   }
// }
