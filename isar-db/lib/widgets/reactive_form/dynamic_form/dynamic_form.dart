import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DynamicForm extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final bool isDraftTicket;
  final bool disabledForm;
  final List<dynamic> draftTaskSpocs;

  DynamicForm({
    required this.data,
    required this.isDraftTicket,
    required this.disabledForm,
    required this.draftTaskSpocs,
  });

  @override
  Widget build(BuildContext context) {
    final formControls = _buildFormControls(data);

    return ReactiveFormBuilder(
      form: () => FormGroup(formControls),
      builder: (context, form, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ...formControls.keys.map(
                (key) => ReactiveTextField(
                  formControlName: key,
                  decoration: InputDecoration(labelText: key),
                ),
              ),
              ElevatedButton(
                onPressed: form.valid
                    ? () {
                        final formData = form.value;
                        print('Form Data: $formData');
                      }
                    : null,
                child: Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, FormControl> _buildFormControls(List<Map<String, dynamic>> data) {
    final controls = <String, FormControl>{};
    for (final field in data[0]['form_data'] ?? []) {
      controls[field['id']] = FormControl<dynamic>(
        value: field['default_value'] ?? '',
        validators: [],
      );
    }
    return controls;
  }
}
