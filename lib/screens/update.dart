//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './taskprovider.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key, required this.id, required this.userID});
  final String id;
  final String userID;
  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

TextEditingController title2Controller = TextEditingController();
TextEditingController desc2Controller = TextEditingController();

class _UpdateTaskState extends State<UpdateTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text("Update Task"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: title2Controller,
                    decoration: const InputDecoration(labelText: 'Task Title'),
                  ),
                  TextField(
                    controller: desc2Controller,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        value.updateTask(
                            title2Controller.text.trim(),
                            desc2Controller.text.trim(),
                            widget.id,
                            widget.userID);
                        title2Controller.clear();
                        desc2Controller.clear();
                        Navigator.pop(context);
                      },
                      child: const Text("Update")),
                ],
              ),
            ),
          )),
    );
  }
}
