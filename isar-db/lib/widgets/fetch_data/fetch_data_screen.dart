import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:letstalkbooksfinished/rest_services/dio_client.dart';

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  final String _submitPath = "http://10.0.2.2:3000/submit-data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        title: const Text(
          "REST API Screen",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _submitData,
          child: const Text("Submit"),
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    try {
      final Map<String, dynamic> data = {
        "bookName": "Example Book",
        "duration": "2 weeks",
        "priorityValue": 1,
      };

      final response = await DioClient.instance.post(_submitPath, data: data);

      print("Response: $response");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data submitted successfully!")),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit data: $e")),
      );
    }
  }
}
