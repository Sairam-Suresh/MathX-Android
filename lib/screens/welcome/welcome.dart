import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mathx_android/screens/root/root.dart';

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
                colors: [Color.fromARGB(255, 169, 100, 255), Colors.white],
                stops: [0.3, 1],
                center: Alignment.topCenter,
                radius: 2)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
              const Spacer(flex: 3),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Column(
                  children: [
                    Center(
                        child: Animate(
                      effects: const [
                        FadeEffect(duration: Duration(milliseconds: 500))
                      ],
                      child: const Text("MathX",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold)),
                    )),
                    Center(
                      child: Animate(
                        effects: const [
                          FadeEffect(
                              duration: Duration(milliseconds: 500),
                              delay: Duration(milliseconds: 500))
                        ],
                        child: const Text("By AppCatalyst Inc",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 6,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        Animate(
                          effects: const [
                            MoveEffect(
                              delay: Duration(milliseconds: 1000),
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 1000),
                            ),
                            FadeEffect(
                              begin: 0.0,
                              duration: const Duration(milliseconds: 1000),
                            )
                          ],
                          child: const Text(
                              "Disclaimer: Please only use this app at the appropriate times and when necessary.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                        const Spacer(flex: 5),
                      ],
                    ),
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Animate(
                    effects: const [
                      MoveEffect(
                          delay: Duration(milliseconds: 2000),
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeInToLinear),
                      FadeEffect(
                        begin: 0.0,
                        duration: Duration(milliseconds: 1000),
                      )
                    ],
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 169, 100, 255)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                        onPressed: () {
                          // TODO: Make the other tab view the permanent view once this view has been dismissed
                          // WARN: During the merge into main make sure that this gets changed to "pushReplacement" during the merge conflict
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => root()),
                          );
                        },
                      ),
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
