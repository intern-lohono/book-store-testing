import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:letstalkbooksfinished/api/books.pb.dart';
import 'package:letstalkbooksfinished/providers/api/grpc_service.dart';

class AddBookDBScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddBookDBScreen> createState() => _AddBookDBScreenState();
}

class _AddBookDBScreenState extends ConsumerState<AddBookDBScreen> {
  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
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
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Please enter a priority',
                    ValidationMessage.number: (_) =>
                        'Priority must be a valid number',
                    ValidationMessage.min: (_) => 'Priority must be at least 1',
                    ValidationMessage.max: (_) =>
                        'Priority cannot be greater than 5',
                  },
                ),
                SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: 'duration',
                  decoration: InputDecoration(
                    labelText: "Duration (e.g., 3h 30m)",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Please enter a duration',
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(
                        onPressed: _sendBookData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: form.valid
                              ? Colors.orange
                              : const Color.fromARGB(255, 238, 193, 125),
                          foregroundColor: Colors.white,
                          elevation: form.valid ? 4 : 0,
                        ),
                        child: form.disabled
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("Send"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendBookData() async {
    if (form.invalid) {
      form.markAllAsTouched();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    final bookService = ref.read(getBookService());

    final book = Book(
      bookName: form.control('bookName').value as String,
      priorityValue: int.parse(form.control('priority').value as String),
      duration: form.control('duration').value as String,
    );

    form.markAsDisabled();

    final response = await bookService.addBook(book);

    form.markAsEnabled();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.success ? 'Book added successfully!' : 'Failed to add book.',
        ),
      ),
    );

    if (response.success) {
      Navigator.pop(context);
    }
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
