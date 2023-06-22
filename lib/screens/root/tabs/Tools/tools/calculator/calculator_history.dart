import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathx_android/logic/tools/CalculatorLogic.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CalculatorHistory extends StatelessWidget {
  const CalculatorHistory(
      {super.key, required this.history, required this.onClearHistory});

  final List<Calculation> history;
  final VoidCallback onClearHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            onPressed: () {
              onClearHistory();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: ListView.separated(
          itemCount: history.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
                  history[index]
                      .expression
                      .replaceAll("*", "×")
                      .replaceAll("/", "÷"),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(history[index].result.toString()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalculationDetailView(
                              calculation: history[index])));
                });
          },
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(),
            );
          }),
    );
  }
}

class CalculationDetailView extends StatelessWidget {
  const CalculationDetailView({super.key, required this.calculation});

  final Calculation calculation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                    "${calculation.expression} = ${calculation.result}",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: QrImageView(
                    data: calculation.base64EncodedLink,
                    backgroundColor: Colors.white,
                  )),
                ),
              ),
            ),
            FilledButton(
                onPressed: () {
                  Share.share(calculation.base64EncodedLink);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Share Link"),
                  ],
                )),
            FilledButton(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: calculation.base64EncodedLink));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Link copied to clipboard!")));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copy),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Copy to Clipboard"),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
