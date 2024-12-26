import 'package:flutter/material.dart';
import 'package:letstalkbooksfinished/widgets/reactive_form/dynamic_form/dynamic_form.dart';
import 'dart:math';

class DynamicFormScreen extends StatelessWidget {
  final List<List<Map<String, dynamic>>> formConfigs = [
    [
      {
        "id": "book_form_1",
        "form_data": [
          {"id": "title", "default_value": "", "label": "Book Title"},
          {"id": "author", "default_value": "", "label": "Author Name"},
          {"id": "priority", "default_value": "", "label": "Priority"},
          {
            "id": "publisher",
            "default_value": "",
            "label": "Publisher",
            "optional": true
          },
        ],
      }
    ],
    [
      {
        "id": "book_form_2",
        "form_data": [
          {"id": "title", "default_value": "", "label": "Book Title"},
          {"id": "author", "default_value": "", "label": "Author Name"},
          {"id": "priority", "default_value": "", "label": "Priority"},
          {
            "id": "genre",
            "default_value": "",
            "label": "Book Genre",
            "optional": true
          },
        ],
      }
    ],
    [
      {
        "id": "book_form_3",
        "form_data": [
          {"id": "title", "default_value": "", "label": "Book Title"},
          {"id": "author", "default_value": "", "label": "Author Name"},
          {"id": "priority", "default_value": "", "label": "Priority"},
          {
            "id": "rating",
            "default_value": "",
            "label": "Rating",
            "optional": true
          },
        ],
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final randomIndex = Random().nextInt(formConfigs.length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Form"),
        backgroundColor: Colors.orange,
      ),
      body: DynamicForm(
        isDraftTicket: false,
        data: formConfigs[randomIndex],
        draftTaskSpocs: [],
        disabledForm: false,
      ),
    );
  }
}