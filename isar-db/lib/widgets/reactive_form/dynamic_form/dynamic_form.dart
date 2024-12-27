import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DynamicForm extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final bool isDraftTicket;

  DynamicForm({
    required this.data,
    required this.isDraftTicket,
  });

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  late FormGroup form;
  final List<Map<String, dynamic>> dynamicFields = [];

  @override
  void initState() {
    super.initState();
    form = createForm();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...buildFormFields(),
            ...dynamicFields.map(
              (field) => ReactiveTextField(
                formControlName: field['id'],
                decoration: InputDecoration(labelText: field['label']),
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
      ),
    );
  }

  FormGroup createForm() {
    final controls = <String, FormControl>{};
    for (final field in widget.data[0]['form_data'] ?? []) {
      controls[field['id']] = FormControl<String>(
        value: field['default_value'] ?? '',
        validators: [],
      );
    }
    return FormGroup(controls);
  }

  List<Widget> buildFormFields() {
    return widget.data[0]['form_data'].map<Widget>((field) {
      if (field['type'] == 'dropdown') {
        return ReactiveDropdownField<String>(
          formControlName: field['id'],
          decoration: InputDecoration(labelText: field['label']),
          items: (field['options'] as List<String>)
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (control) => onTitleChanged(control.value),
        );
      } else {
        return ReactiveTextField(
          formControlName: field['id'],
          decoration: InputDecoration(labelText: field['label']),
        );
      }
    }).toList();
  }

  void onTitleChanged(String? value) {
    if (value == "Clear Light of Day" || value == "The Inheritance of Loss") {
      if (!dynamicFields.any((field) => field['id'] == 'edition')) {
        setState(() {
          dynamicFields.add({"id": "edition", "label": "Edition"});
          form.addAll({
            'edition': FormControl<String>(value: '', validators: []),
          });
        });
      }
    } else {
      if (dynamicFields.any((field) => field['id'] == 'edition')) {
        setState(() {
          dynamicFields.removeWhere((field) => field['id'] == 'edition');
          form.removeControl('edition');
        });
      }
    }
  }
}
