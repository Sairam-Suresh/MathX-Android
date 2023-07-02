import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Unit {
  late String title;
  late Map units;

  Unit(this.title, this.units);
}

var units = {
  ConversionType.length: {
    "centimeters": 1,
    "meters": 100,
    "kilometers": 100000,
    "inches": 2.54,
    "feet": 30.48,
    "yards": 91.44,
    "miles": 160934.4,
  },
  ConversionType.area: {
    "Acres": 6272640,
    "Hectares": 15500031,
    "Square Metres": 1550,
    "Square Kilometres": 1550003100,
    "Square Inches": 1,
    "Square Feet": 144,
  },
  ConversionType.volume: {
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
  },
  ConversionType.mass: {
    "Grams": 1,
    "Kilograms": 1000,
    "Ounces": 28.3495,
    "Pounds": 453.592,
    "Metric Tons": 1000000,
    "Carats": 0.2,
  },
  ConversionType.speed: {
    "m/s": 1,
    "km/h": 1000,
    "mi/h": 1609.344,
    "knots": 0.5144444444,
  },
  ConversionType.temperature: {
    "Celsius": 1,
    "Fahrenheit": 1000,
    "Kelvin": 1609.344,
  },
};

var unitsIcons = {
  ConversionType.length: Icons.straighten,
  ConversionType.area: Icons.square,
  ConversionType.mass: Icons.scale,
  ConversionType.volume: MdiIcons.cubeOutline,
  ConversionType.speed: Icons.speed,
  ConversionType.temperature: Icons.thermostat,
};

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  ConversionType _currentConversionType = ConversionType.length;
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  double _inputValue = 0.0;
  double _outputValue = 0.0;
  String inputType = "centimeters";
  String outputType = "meters";

  String convertValue(
      String from, String to, ConversionType type, double value) {
    var typeUnits = units[type]!;
    debugPrint(type.toString());
    debugPrint(from);
    debugPrint(to);
    debugPrint(typeUnits[to].toString());
    var res = 0.0;
    if (type == ConversionType.temperature) {
      if (from == to) {
        res = value;
      } else {
        if (from == "Kelvin") {
          // from kelvin
          res =
              to == "Celsius" ? value - 273.15 : (value - 273.15) * 9 / 5 + 32;
        } else if (from == "Fahrenheit") {
          // from fahrenheit
          res = to == "Celsius"
              ? (value - 32) * 5 / 9
              : (value - 32) * 5 / 9 + 273.15;
        } else {
          // from celsius
          res = to == "Fahrenheit" ? (value * 9 / 5) + 32 : value + 273.15;
        }
      }
    } else {
      res = value * typeUnits[from]! / typeUnits[to]!;
    }
    _outputValue = res;
    return res.toString();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Unit Converter"),
          bottom: TabBar(
            tabs: ConversionType.values
                .map((type) => Tab(
                      icon: Icon(unitsIcons[type]),
                    ))
                .toList(),
            onTap: (index) {
              setState(() {
                setState(() {
                  _inputController.text = "";
                  _outputController.text = "";
                  _inputValue = 0.0;
                  _outputValue = 0.0;
                  inputType =
                      units[ConversionType.values[index]]!.entries.first.key;
                  outputType = units[ConversionType.values[index]]!
                      .entries
                      .elementAt(1)
                      .key;
                  _currentConversionType = ConversionType.values[index];
                });
              });
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16.0),
            // INPUT
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Input',
                    ),
                    onChanged: (value) {
                      _inputValue = double.parse(value);
                      _outputController.text = convertValue(
                          inputType,
                          outputType,
                          _currentConversionType,
                          double.parse(value));
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: units[_currentConversionType]?.entries.first.key,
                    onChanged: (String? newValue) {
                      inputType = newValue!;
                      _outputController.text = convertValue(newValue,
                          outputType, _currentConversionType, _inputValue);
                    },
                    items: units[_currentConversionType]!.entries.map((unit) {
                      return DropdownMenuItem<String>(
                        value: unit.key,
                        child: Text(unit.key,
                            style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            // OUTPUT
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: TextField(
                    controller: _outputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Output',
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value:
                        units[_currentConversionType]?.entries.elementAt(1).key,
                    onChanged: (String? newValue) {
                      outputType = newValue!;
                      _outputController.text = convertValue(inputType, newValue,
                          _currentConversionType, _inputValue);
                    },
                    items: units[_currentConversionType]!.entries.map((unit) {
                      return DropdownMenuItem<String>(
                        value: unit.key,
                        child: Text(unit.key,
                            style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

enum ConversionType {
  length,
  area,
  mass,
  volume,
  speed,
  temperature,
}

// class SegmentedButton<T> extends StatelessWidget {
//   final List<ButtonSegment<T>> segments;
//   final T selected;
//   final ValueChanged<T> onSelectionChanged;

//   SegmentedButton({
//     required this.segments,
//     required this.selected,
//     required this.onSelectionChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//       children: segments.map((segment) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: segment.child,
//         );
//       }).toList(),
//       isSelected: segments.map((segment) {
//         return segment.value == selected;
//       }).toList(),
//       onPressed: (int index) {
//         onSelectionChanged(segments[index].value);
//       },
//     );
//   }
// }

// class ButtonSegment<T> {
//   final T value;
//   final Widget child;

//   ButtonSegment({
//     required this.value,
//     required this.child,
//   });
// }

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

// import 'package:flutter/material.dart';

// enum ConversionType {
//   length,
//   area,
//   mass,
//   volume,
//   speed,
//   temperature,
// }

// class UnitConverter extends StatefulWidget {
//   @override
//   _UnitConverterState createState() => _UnitConverterState();
// }

// class _UnitConverterState extends State<UnitConverter> {
//   ConversionType _currentConversionType = ConversionType.length;
//   TextEditingController _inputController = TextEditingController();
//   TextEditingController _outputController = TextEditingController();
//   double _inputValue = 0.0;
//   double _outputValue = 0.0;

//   Map<ConversionType, List<String>> _unitOptions = {
//     ConversionType.length: ['Meter', 'Kilometer', 'Mile'],
//     ConversionType.area: ['Square meter', 'Square kilometer', 'Square mile'],
//     ConversionType.mass: ['Gram', 'Kilogram', 'Pound'],
//     ConversionType.volume: ['Cubic meter', 'Liter', 'Gallon'],
//     ConversionType.speed: ['Meter/second', 'Kilometer/hour', 'Mile/hour'],
//     ConversionType.temperature: ['Celsius', 'Fahrenheit', 'Kelvin'],
//   };

//   Map<ConversionType, String> _conversionTypeLabels = {
//     ConversionType.length: 'Length',
//     ConversionType.area: 'Area',
//     ConversionType.mass: 'Mass',
//     ConversionType.volume: 'Volume',
//     ConversionType.speed: 'Speed',
//     ConversionType.temperature: 'Temperature',
//   };

//   // Map<String, double> _conversionRates = {
//   //   'Meter-Kilometer': 0.001,
//   //   'Meter-Mile': 0.000621371,
//   //   'Kilometer-Meter': 1000,
//   //   'Kilometer-Mile': 0.621371,
//   //   'Mile-Meter': 1609.34,
//   //   'Mile-Kilometer': 1.60934,
//   //   // Add conversion rates for other units here
//   // };

// Map<String, double> _conversionRates = {
//   // Length
//   'Meter-Kilometer': 0.001,
//   'Meter-Mile': 0.000621371,
//   'Kilometer-Meter': 1000,
//   'Kilometer-Mile': 0.621371,
//   'Mile-Meter': 1609.34,
//   'Mile-Kilometer': 1.60934,

//   // Area
//   'Square meter-Square kilometer': 0.000001,
//   'Square meter-Square mile': 3.861e-7,
//   'Square kilometer-Square meter': 1000000,
//   'Square kilometer-Square mile': 0.386102,
//   'Square mile-Square meter': 2589988.11,
//   'Square mile-Square kilometer': 2.58999,

//   // Mass
//   'Gram-Kilogram': 0.001,
//   'Gram-Pound': 0.00220462,
//   'Kilogram-Gram': 1000,
//   'Kilogram-Pound': 2.20462,
//   'Pound-Gram': 453.592,
//   'Pound-Kilogram': 0.453592,

//   // Volume
//   'Cubic meter-Liter': 1000,
//   'Cubic meter-Gallon': 264.172,
//   'Liter-Cubic meter': 0.001,
//   'Liter-Gallon': 0.264172,
//   'Gallon-Cubic meter': 3.78541,
//   'Gallon-Liter': 3.78541,

//   // Speed
//   'Meter/second-Kilometer/hour': 3.6,
//   'Meter/second-Mile/hour': 2.23694,
//   'Kilometer/hour-Meter/second': 0.277778,
//   'Kilometer/hour-Mile/hour': 0.621371,
//   'Mile/hour-Meter/second': 0.44704,
//   'Mile/hour-Kilometer/hour': 1.60934,

//   // Temperature
//   'Celsius-Fahrenheit': 33.8,
//   'Celsius-Kelvin': 274.15,
//   'Fahrenheit-Celsius': -17.2222,
//   'Fahrenheit-Kelvin': 255.928,
//   'Kelvin-Celsius': -272.15,
//   'Kelvin-Fahrenheit': -457.87,
// };

//   @override
//   void dispose() {
//     _inputController.dispose();
//     _outputController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Unit Converter'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildSegmentedButton(),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: 2,
//                 childAspectRatio: 3.0,
//                 children: [
//                   _buildInputTextField(),
//                   _buildDropdown(_currentConversionType, _unitOptions[_currentConversionType]!, true),
//                   _buildOutputTextField(),
//                   _buildDropdown(_currentConversionType, _unitOptions[_currentConversionType]!, false),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _convertUnits,
//                 child: Text('Convert'),
//               ),
//               SizedBox(height: 16.0),

//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSegmentedButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: ToggleButtons(
//         isSelected: ConversionType.values.map((type) => type == _currentConversionType).toList(),
//         onPressed: (int newIndex) {
//           setState(() {
//             _currentConversionType = ConversionType.values[newIndex];
//           });
//         },
//         children: ConversionType.values.map((type) => Text(_conversionTypeLabels[type]!)).toList(),
//       ),
//     );
//   }

//   Widget _buildDropdown(ConversionType conversionType, List<String> unitOptions, bool isFrom) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: DropdownButtonFormField<String>(
//         value: isFrom ? _unitOptions[conversionType]![0] : _unitOptions[conversionType]![1],
//         onChanged: (String? newValue) {},
//         items: unitOptions.map((unit) {
//           return DropdownMenuItem<String>(
//             value: unit,
//             child: Text(unit),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildInputTextField() {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: TextField(
//           controller: _inputController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Input',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOutputTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: TextField(
//         controller: _outputController,
//         enabled: false,
//         decoration: InputDecoration(
//           labelText: 'Output',
//         ),
//       ),
//     );
//   }

//   void _convertUnits() {
//     double inputValue = double.tryParse(_inputController.text) ?? 0.0;
//     double outputValue;

//     String selectedConversion = '${_unitOptions[_currentConversionType]![0]}-${_unitOptions[_currentConversionType]![1]}';
//     double conversionRate = _conversionRates[selectedConversion] ?? 1.0;

//     outputValue = inputValue * conversionRate;

//     setState(() {
//       _inputValue = inputValue;
//       _outputValue = outputValue;
//       _outputController.text = _outputValue.toString();
//     });
//   }
// }

// void main() {
//   runApp(MaterialApp(home: UnitConverter()));
// }
