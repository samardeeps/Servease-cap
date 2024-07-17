import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

Future<void> comparePhotos(
    File photo1, File photo2, Function updateResult) async {
  final uri = Uri.parse('http://192.168.1.41:5000/compare');
  final request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('photo1', photo1.path))
    ..files.add(await http.MultipartFile.fromPath('photo2', photo2.path));

  final response = await request.send();
  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final result = jsonDecode(responseData);
    updateResult(result['verified'].toString());
  } else {
    updateResult('Error: ${response.reasonPhrase}');
  }
}

class ComparePhotosScreen extends StatefulWidget {
  @override
  _ComparePhotosScreenState createState() => _ComparePhotosScreenState();
}

class _ComparePhotosScreenState extends State<ComparePhotosScreen> {
  String result = "";

  void updateResult(String newResult) {
    setState(() {
      result = newResult;
    });
  }

  Future<void> pickAndComparePhotos() async {
    final picker = ImagePicker();
    final pickedFile1 = await picker.pickImage(source: ImageSource.gallery);
    final pickedFile2 = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile1 != null && pickedFile2 != null) {
      final photo1 = File(pickedFile1.path);
      final photo2 = File(pickedFile2.path);

      await comparePhotos(photo1, photo2, updateResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Photos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickAndComparePhotos,
              child: Text('Pick and Compare Photos'),
            ),
            SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}
