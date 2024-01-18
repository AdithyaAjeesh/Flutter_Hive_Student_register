import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_student_register/Data/data_model.dart';
import 'package:flutter_student_register/Functions/functions.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : const AssetImage(
                            "assets/WhatsApp Image 2023-10-16 at 2.19.59 PM.jpeg")
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                pickImageGallery();
              },
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Name';
                          } else {
                            return null;
                          }
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'Enter the Name',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Age';
                          } else {
                            return null;
                          }
                        },
                        controller: ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'Enter the Age',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Address';
                          } else {
                            return null;
                          }
                        },
                        controller: addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'Enter the Address',
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              onAddstudent();
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(Icons.add))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onAddstudent() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final address = addressController.text.trim();
    if (name.isNotEmpty || age.isNotEmpty || address.isNotEmpty) {
      final student = StudentModel(
          name: name, age: age, address: address, image: selectedImage!.path);
      addStudent(student);
    } else {
      return;
    }
  }

  Future pickImageGallery() async {
    final returntheImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returntheImage != null) {
      setState(() {
        selectedImage = File(returntheImage.path);
      });
    }
  }
}
