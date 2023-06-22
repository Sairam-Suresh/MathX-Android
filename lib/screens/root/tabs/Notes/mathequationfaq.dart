import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/textwithequations.dart';

class MathEquationFAQ extends StatelessWidget {
  const MathEquationFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Rendering FAQ'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: const Text('What is Math Rendering?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: TextWithEquations(
                  text:
                      'Math Rendering allows you to input mathematical equations using LaTeX. Example: \\[x=\\frac{1}{2}\\]',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do you type LaTeX equations?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Column(
                  children: [
                    const Text(
                      'You can start LaTeX equations using \\[ and end it with \\]. Example: \\[x=\\frac{1}{2}\\]',
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(child: Text('\\[\\frac{1}{2}\\]')),
                        TextWithEquations(text: '\\[\\frac{1}{2}\\]'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('What are some examples of LaTeX?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Text('Indices/Index - \\[4^7\\]')),
                        TextWithEquations(text: '\\[4^7\\]'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(
                            child: Text('Fractions - \\[\\frac{3}{7}\\]')),
                        TextWithEquations(text: '\\[\\frac{3}{7}\\]'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Square root -\n\\[x=\\pm\\sqrt[4]{b^2-4ac}\\]',
                          ),
                        ),
                        TextWithEquations(
                            text: '\\[x=\\pm\\sqrt[4]{b^2-4ac}\\]'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'You can also search online for more LaTeX functions.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What if I don\'t want to use Math Rendering?'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  'Your texts will be rendered in plain text and appear as normal characters. You can always choose to enable/disable Math Rendering later on.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text(
                'Why can\'t I edit my notes when Math Rendering is enabled?'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  'To edit your notes when Math Rendering is enabled, press the "Edit" button in the top right hand corner of your note. Non-Math Rendering notes can be edited without needing to click on the "Edit" button.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text(
                'Why won\'t my texts leave a line when Math Rendering is enabled?'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  'Leave a line when Math Rendering is enabled:\n\nIf your line ends with a LaTeX equation, add a space at the end of your line. Example: "\\[x=\\frac{2}{5}\\] "\n\nIf your line starts with a LaTeX equation, add a space at the start of your line. Example: " \\[x=\\frac{2}{5}\\]"',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
