import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_student_register/Data/data_model.dart';
import 'package:flutter_student_register/Functions/functions.dart';
import 'package:flutter_student_register/Pages/add_student.dart';
import 'package:flutter_student_register/Pages/edit_students.dart';
import 'package:flutter_student_register/Pages/view_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  List<StudentModel> searchedList = [];
  void searchListUpdate() {
    getAllStudent();
    searchedList = studentListNotifier.value
        .where((studentModel) =>
            studentModel.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Register'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchListUpdate();
                });
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return search.isNotEmpty
                    ? searchedList.isEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                            ),
                          )
                        : buildStudentList(searchedList)
                    : buildStudentList(studentList);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddStudent()));
        },
        child: const Text('+'),
      ),
    );
  }

  Widget buildStudentList(List<StudentModel> students) {
    return students.isEmpty
        ? const Center(
            child: Text(
              'No students available.',
            ),
          )
        : ListView.separated(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final data = students[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewProfile(
                        name: data.name,
                        age: data.age,
                        address: data.address,
                        imagePath: data.image ?? '',
                      ),
                    ),
                  );
                },
                title: Text(
                  data.name,
                ),
                subtitle: Text(
                  data.age,
                ),
                leading: CircleAvatar(
                  backgroundImage: data.image != null
                      ? FileImage(File(data.image!))
                      : const AssetImage("assets/studentdp.jpg.png")
                          as ImageProvider,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditStudent(
                              index: index,
                              name: data.name,
                              address: data.address,
                              age: data.age,
                              imagePath: data.image ?? "",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete this student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteStudent(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              );
            },
          );
  }
}
