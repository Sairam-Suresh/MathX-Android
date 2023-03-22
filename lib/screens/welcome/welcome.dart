import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                radius: 2)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
              const Spacer(flex: 3),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  children: [
                    Center(
                        child: Animate(
                      effects: [FadeEffect(duration: Duration(seconds: 2))],
                      child: Text("MathX",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    )),
                    Text("By AppCatalyst Inc",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 8,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Spacer(flex: 2),
                        Text(
                            "Disclaimer: Please only use this app at the appropriate times and when necessary.",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center),
                        Spacer(flex: 5),
                      ],
                    ),
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purpleAccent),
                      ),
                      child: Text("Get Started"),
                      onPressed: () {},
                    ),
                  )),
              const Spacer(flex: 2),
            ]),
          ),
        ),
      ),
    );
  }
}
