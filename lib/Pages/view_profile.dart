import 'dart:io';

import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final String name;
  final String age;
  final String address;
  final String imagePath;

  const ViewProfile(
      {super.key,
      required this.name,
      required this.age,
      required this.address,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(imagePath)),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  Title(
                    color: Colors.black,
                    child: const Center(
                      child: Text('Name : '),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 60,
                    child: Center(
                      child: Text(name),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  Title(
                    color: Colors.black,
                    child: const Center(
                      child: Text('Age : '),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 60,
                    child: Center(
                      child: Text(age),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  Title(color: Colors.black, child: const Text('Address : ')),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 60,
                    child: Center(
                      child: Text(address),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
