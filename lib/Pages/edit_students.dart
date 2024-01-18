import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_student_register/Data/data_model.dart';
import 'package:flutter_student_register/Functions/functions.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  String name;
  String age;
  String address;
  int index;
  dynamic imagePath;
  EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.address,
    required this.index,
    required this.imagePath,
  });

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  File? selectedImage;
  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _addressController = TextEditingController(text: widget.address);
    selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 80,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : const AssetImage(
                            "assets/WhatsApp Image 2023-10-16 at 2.19.59 PM.jpeg")
                        as ImageProvider,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  pickImageGallery();
                },
                label: const Text('Gallery'),
                icon: const Icon(Icons.image),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Enter the Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Enter the Age',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Enter the Address',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  editAll();
                  Navigator.pop(context);
                },
                child: const Text('Edit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAll() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _address = _addressController.text.trim();
    final _Image = selectedImage!.path;
    if (_name.isNotEmpty || _age.isNotEmpty || _address.isNotEmpty) {
      final update = StudentModel(
          name: _name, age: _age, address: _address, image: _Image);
      editStudent(widget.index, update);
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
