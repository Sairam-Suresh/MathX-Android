import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.purpleAccent, Colors.white],
                stops: [0.0, 1.0],
                center: Alignment.topCenter,
                radius: 1.5)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
              const Spacer(flex: 1),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  children: const [
                    Center(
                        child: Text("MathX",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold))),
                    Text("By AppCatalyst Inc",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                        "Disclaimer: Please only use this app at the appropriate times and when necessary.",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
