import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DynamicForm extends StatefulWidget {
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
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  late FormGroup _form;
  final List<Map<String, dynamic>> _dynamicFields = [];

  @override
  void initState() {
    super.initState();
    _form = _createForm();
  }

  FormGroup _createForm() {
    final controls = <String, FormControl>{};
    for (final field in widget.data[0]['form_data'] ?? []) {
      controls[field['id']] = FormControl<String>(
        value: field['default_value'] ?? '',
        validators: [],
      );
    }
    return FormGroup(controls);
  }

  void _onTitleChanged(String? value) {
    if (value == "Option 3" || value == "Option 4") {
      if (!_dynamicFields.any((field) => field['id'] == 'new_field')) {
        setState(() {
          _dynamicFields.add({"id": "new_field", "label": "Edition"});
          _form.addAll({
            'new_field': FormControl<String>(value: '', validators: []),
          });
        });
      }
    } else {
      if (_dynamicFields.any((field) => field['id'] == 'new_field')) {
        setState(() {
          _dynamicFields.removeWhere((field) => field['id'] == 'new_field');
          _form.removeControl('new_field');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...widget.data[0]['form_data'].map<Widget>((field) {
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
                  onChanged: (control) => _onTitleChanged(control.value),
                );
              } else {
                return ReactiveTextField(
                  formControlName: field['id'],
                  decoration: InputDecoration(labelText: field['label']),
                );
              }
            }).toList(),
            ..._dynamicFields.map(
              (field) => ReactiveTextField(
                formControlName: field['id'],
                decoration: InputDecoration(labelText: field['label']),
              ),
            ),
            ElevatedButton(
              onPressed: _form.valid
                  ? () {
                      final formData = _form.value;
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
}
