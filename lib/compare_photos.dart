// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// Future<void> comparePhotos(
//     File photo1, File photo2, Function updateResult) async {
//   final uri = Uri.parse('http://192.168.1.41:5000/compare');
//   final request = http.MultipartRequest('POST', uri)
//     ..files.add(await http.MultipartFile.fromPath('photo1', photo1.path))
//     ..files.add(await http.MultipartFile.fromPath('photo2', photo2.path));

//   final response = await request.send();
//   if (response.statusCode == 200) {
//     final responseData = await response.stream.bytesToString();
//     final result = jsonDecode(responseData);
//     updateResult(result['verified'].toString());
//   } else {
//     updateResult('Error: ${response.reasonPhrase}');
//   }
// }

// class ComparePhotosScreen extends StatefulWidget {
//   @override
//   _ComparePhotosScreenState createState() => _ComparePhotosScreenState();
// }

// class _ComparePhotosScreenState extends State<ComparePhotosScreen> {
//   String result = "";
//   File? photo1;
//   File? photo2;

//   bool isPhoto1Uploaded = false;
//   bool isPhoto2Uploaded = false;
//   bool isLoading = false;

//   // TextEditingControllers for the text fields
//   TextEditingController field1 = TextEditingController();
//   TextEditingController field2 = TextEditingController();
//   TextEditingController field3 = TextEditingController();
//   TextEditingController field4 = TextEditingController();
//   TextEditingController field5 = TextEditingController();
//   TextEditingController field6 = TextEditingController();
//   TextEditingController field7 = TextEditingController();

//   void updateResult(String newResult) {
//     setState(() {
//       result = newResult;
//       isLoading = false;
//     });
//   }

//   Future<void> pickPhoto(int photoNumber,
//       {ImageSource source = ImageSource.gallery}) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       setState(() {
//         if (photoNumber == 1) {
//           photo1 = File(pickedFile.path);
//           isPhoto1Uploaded = true;
//         } else if (photoNumber == 2) {
//           photo2 = File(pickedFile.path);
//           isPhoto2Uploaded = true;
//         }
//       });
//     }
//   }

//   Future<void> selectPhotoSource(int photoNumber) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Choose Photo Source"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text("Camera"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   pickPhoto(photoNumber, source: ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo),
//                 title: Text("Gallery"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   pickPhoto(photoNumber, source: ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> verifyPhotos() async {
//     if (photo1 != null && photo2 != null) {
//       setState(() {
//         isLoading = true;
//       });
//       await comparePhotos(photo1!, photo2!, updateResult);
//     } else {
//       updateResult('Please select both photos.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.grey[200],
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 155),
//                   TextField(
//                     controller: field1,
//                     decoration: InputDecoration(
//                       labelText: 'Name',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: field2,
//                     decoration: InputDecoration(
//                       labelText: 'Email ID',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: field3,
//                     decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: field4,
//                     decoration: InputDecoration(
//                       labelText: 'Verify pin',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: field5,
//                     decoration: InputDecoration(
//                       labelText: 'Pincode',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: field6,
//                     decoration: InputDecoration(
//                       labelText: 'Set Password',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: field7,
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: () => selectPhotoSource(1),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         backgroundColor: isPhoto1Uploaded
//                             ? Colors.green.shade100
//                             : Colors.blue.shade100,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       icon: isPhoto1Uploaded
//                           ? const Icon(Icons.check, color: Colors.green)
//                           : const Icon(Icons.upload, color: Colors.blue),
//                       label: Text(
//                         isPhoto1Uploaded
//                             ? 'Photo Uploaded'
//                             : 'Upload your photo',
//                         style: TextStyle(
//                           color: isPhoto1Uploaded ? Colors.green : Colors.blue,
//                           fontSize: 16,
//                           fontFamily: 'uber',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: () => selectPhotoSource(2),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         backgroundColor: isPhoto2Uploaded
//                             ? Colors.green.shade100
//                             : Colors.blue.shade100,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       icon: isPhoto2Uploaded
//                           ? const Icon(Icons.check, color: Colors.green)
//                           : const Icon(Icons.upload, color: Colors.blue),
//                       label: Text(
//                         isPhoto2Uploaded
//                             ? 'Aadhar Uploaded'
//                             : 'Upload Aadhar card',
//                         style: TextStyle(
//                           color: isPhoto2Uploaded ? Colors.green : Colors.blue,
//                           fontSize: 16,
//                           fontFamily: 'uber',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: verifyPhotos,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         backgroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: isLoading
//                           ? CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : const Text(
//                               'Verify',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontFamily: 'uber',
//                               ),
//                             ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Center(
//                     child: Text(result),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: Colors.grey[200],
//               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Get.back(),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'uber',
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     "Welcome to Servease",
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey[600],
//                       fontFamily: 'pro-bold',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:servease_cap/splash/animated-check.dart';
import 'package:servease_cap/splash/verified.dart';

Future<void> comparePhotos(
    File photo1, File photo2, Function updateResult) async {
  final uri = Uri.parse('http://192.168.1.36:5000/compare');
  final request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('photo1', photo1.path))
    ..files.add(await http.MultipartFile.fromPath('photo2', photo2.path));

  final response = await request.send();
  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final result = jsonDecode(responseData);
    updateResult(result['verified']);
  } else {
    updateResult(null, error: 'Error: ${response.reasonPhrase}');
  }
}

class ComparePhotosScreen extends StatefulWidget {
  @override
  _ComparePhotosScreenState createState() => _ComparePhotosScreenState();
}

class _ComparePhotosScreenState extends State<ComparePhotosScreen> {
  String result = "";
  File? photo1;
  File? photo2;

  bool isPhoto1Uploaded = false;
  bool isPhoto2Uploaded = false;
  bool isLoading = false;
  bool isVerified = false;

  // TextEditingControllers for the text fields
  TextEditingController field1 = TextEditingController();
  TextEditingController field2 = TextEditingController();
  TextEditingController field3 = TextEditingController();
  TextEditingController field4 = TextEditingController();
  TextEditingController field5 = TextEditingController();
  TextEditingController field6 = TextEditingController();
  TextEditingController field7 = TextEditingController();

  void updateResult(bool? isVerified, {String? error}) {
    setState(() {
      if (isVerified != null) {
        Get.to(() => VerificationCompleteScreen());
      } else {
        result = error ?? 'Unknown error';
      }
      isLoading = false;
    });
  }

  Future<void> pickPhoto(int photoNumber,
      {ImageSource source = ImageSource.gallery}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (photoNumber == 1) {
          photo1 = File(pickedFile.path);
          isPhoto1Uploaded = true;
        } else if (photoNumber == 2) {
          photo2 = File(pickedFile.path);
          isPhoto2Uploaded = true;
        }
      });
    }
  }

  Future<void> selectPhotoSource(int photoNumber) async {
    if (photoNumber == 1) {
      pickPhoto(photoNumber, source: ImageSource.camera);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Photo Source"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    pickPhoto(photoNumber, source: ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    pickPhoto(photoNumber, source: ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> verifyPhotos() async {
    if (photo1 != null && photo2 != null) {
      setState(() {
        isLoading = true;
      });
      await comparePhotos(photo1!, photo2!, updateResult);
    } else {
      updateResult(null, error: 'Please select both photos.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 155),
                  TextField(
                    controller: field1,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: field2,
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: field3,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: field4,
                    decoration: InputDecoration(
                      labelText: 'Verify pin',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: field5,
                    decoration: InputDecoration(
                      labelText: 'Pincode',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: field6,
                    decoration: InputDecoration(
                      labelText: 'Set Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: field7,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => selectPhotoSource(1),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: isPhoto1Uploaded
                            ? Colors.green.shade100
                            : Colors.blue.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: isPhoto1Uploaded
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.upload, color: Colors.blue),
                      label: Text(
                        isPhoto1Uploaded
                            ? 'Photo Uploaded'
                            : 'Upload your photo',
                        style: TextStyle(
                          color: isPhoto1Uploaded ? Colors.green : Colors.blue,
                          fontSize: 16,
                          fontFamily: 'uber',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => selectPhotoSource(2),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: isPhoto2Uploaded
                            ? Colors.green.shade100
                            : Colors.blue.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: isPhoto2Uploaded
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.upload, color: Colors.blue),
                      label: Text(
                        isPhoto2Uploaded
                            ? 'Aadhar Uploaded'
                            : 'Upload Aadhar card',
                        style: TextStyle(
                          color: isPhoto2Uploaded ? Colors.green : Colors.blue,
                          fontSize: 16,
                          fontFamily: 'uber',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Register as a',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: ['Electrician', 'Plumber', 'Carpenter']
                        .map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        // Do something with the selected value (newValue)
                      });
                    },
                  ),
                  const SizedBox(height: 150),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: verifyPhotos,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'uber',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: isVerified ? AnimatedTick() : Text(result),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'uber',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Welcome to Servease",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                      fontFamily: 'pro-bold',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
