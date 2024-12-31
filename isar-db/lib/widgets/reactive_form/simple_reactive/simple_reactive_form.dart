import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SimpleReactiveForm extends StatelessWidget {
  SimpleReactiveForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: 'bookName',
                  decoration: InputDecoration(
                    labelText: "Book Name",
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Please enter a book name',
                  },
                ),
                SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: 'priority',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Priority (1-5)",
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Please enter a priority',
                    ValidationMessage.pattern: (_) =>
                        'Priority must be between 1 and 5',
                  },
                ),
                SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: 'duration',
                  decoration: InputDecoration(
                    labelText: "Duration (e.g., 3h 30m)",
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Please enter a duration',
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (form.valid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Form is valid!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        form.markAllAsTouched();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all required fields.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final form = FormGroup({
    'bookName': FormControl<String>(
      value: null,
      validators: [Validators.required],
    ),
    'priority': FormControl<String>(
      value: null,
      validators: [
        Validators.required,
        Validators.pattern(r'^[1-5]$'),
      ],
    ),
    'duration': FormControl<String>(
      value: null,
      validators: [Validators.required],
    ),
  });
}
