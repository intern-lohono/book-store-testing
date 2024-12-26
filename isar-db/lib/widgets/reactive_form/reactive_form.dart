import 'package:flutter/material.dart';
import 'package:letstalkbooksfinished/widgets/reactive_form/dynamic_form/dynamic_form_screen.dart';
import 'package:letstalkbooksfinished/widgets/reactive_form/simple_reactive/simple_reactive_form.dart';

class ReactiveForm extends StatelessWidget {
  const ReactiveForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cardDetails = [
      {'title': 'Simple Reactive Form', 'icon': Icons.looks_one},
      {'title': 'Dynamic Form', 'icon': Icons.looks_two},
      // {'title': 'Screen Three', 'icon': Icons.looks_3},
      // {'title': 'Screen Four', 'icon': Icons.looks_4},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Types of Reactive Forms'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cardDetails.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleReactiveForm(),
                  ),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DynamicFormScreen(),
                  ),
                );
              }
              // else if (index == 2) {
              //   // Screen 3: Navigate to Reactive Form 3
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ReactiveForm3(),
              //     ),
              //   );
              // } else if (index == 3) {
              //   // Screen 4: Navigate to Reactive Form 4
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ReactiveForm4(),
              //     ),
              //   );
              // }
            },
            child: Card(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cardDetails[index]['icon'] as IconData,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cardDetails[index]['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
