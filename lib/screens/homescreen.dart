//import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_tutorial/screens/completed_tasks.dart';
import 'package:firebase_tutorial/screens/email_auth/login_screen.dart';
import 'package:firebase_tutorial/screens/status_provider.dart';
import 'package:firebase_tutorial/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
//import 'package:uuid/v1.dart';
import './taskprovider.dart';
//import './email_auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userID});
  final String? userID;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void logOut() async {
    FirebaseAuth.instance.signOut();
  }

  bool isDone = false;
  File? profilepic;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  void saveUserData() async {
    bool isDone = false;
    String title = titleController.text.trim();
    String description = descController.text.trim();
    String userID = widget.userID!;
    String category = categoryController.text.trim();
    UploadTask task = FirebaseStorage.instance
        .ref()
        .child("profilepics")
        .child(const Uuid().v1())
        .putFile(profilepic!);
    TaskSnapshot taskSnapshot = await task;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (title != "" ||
        description != "" ||
        profilepic != null ||
        category != "") {
      Map<String, dynamic> userData = {
        "Title": title,
        "Description": description,
        "Profile pic": downloadUrl,
        "Category": category,
        "Status": isDone
      };
      FirebaseFirestore.instance.collection(userID).doc().set(userData);
      showModalBottomSheet(
        context: context,
        builder: (context) => const SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: Center(
            child: Text(
              "Task Added !",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      );
      titleController.clear();
      descController.clear();
      categoryController.clear();
      setState(() {
        profilepic = null;
      });
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: Center(
            child: Text(
              "Please fill all the fields",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => SingleChildScrollView(
        child: Scaffold(
          bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: 60,
            child: Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 31, 31, 31),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 46, 46, 46),
                          offset: Offset(0, -2),
                          blurRadius: 10)
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.home_outlined,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 40,
                        ),
                      ),
                      Consumer<StatusProvider>(
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CompletedTasks(
                                    userID: widget.userID, isDone: isDone)));
                          },
                          icon: const Icon(
                            Icons.checklist_rounded,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 40,
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    logOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(Icons.exit_to_app)),
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.replay_outlined))
            ],
            title: const Text(
              'Home',
              // style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            // backgroundColor: Color.fromARGB(255, 178, 36, 255),
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      File imgfile = File(image.path);
                      setState(() {
                        profilepic = imgfile;
                      });
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        (profilepic != null) ? FileImage(profilepic!) : null,
                    backgroundColor: Colors.grey,
                    radius: 40,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: DropdownMenu(
                        controller: categoryController,
                        label: const Text("Task Category"),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                              value: UuidValue, label: "Work/Professional"),
                          DropdownMenuEntry(
                              value: UuidValue, label: "Personal"),
                          DropdownMenuEntry(
                              value: UuidValue, label: "Financial"),
                          DropdownMenuEntry(
                              value: UuidValue, label: "Food related"),
                          DropdownMenuEntry(
                              value: UuidValue, label: "Health and Fitness"),
                          DropdownMenuEntry(value: UuidValue, label: "Hobbies"),
                          DropdownMenuEntry(value: UuidValue, label: "Travel"),
                          DropdownMenuEntry(
                              value: UuidValue, label: "Appointments"),
                          DropdownMenuEntry(
                              value: UuidValue, label: "Miscellanous"),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        saveUserData();
                      },
                      child: const Text("Save")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<StatusProvider>(
                  builder: (context, value, child) => StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(widget.userID!)
                          .where("Status", isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Expanded(
                                child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> newUserMap =
                                    snapshot.data!.docs[index].data();
                                bool status = newUserMap["Status"];
                                // as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 0),
                                  child: Card(
                                      elevation: 4,
                                      // color:
                                      //     const Color.fromARGB(255, 255, 202, 26),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  newUserMap[
                                                                      "Profile pic"]),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            newUserMap["Title"],
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            String id = snapshot
                                                                .data!
                                                                .docs[index]
                                                                .id;
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            UpdateTask(
                                                                              id: id,
                                                                              userID: widget.userID!,
                                                                            )));
                                                            // setState(() {
                                                            //   String title2 =
                                                            //       title2Controller.text
                                                            //           .trim();
                                                            //   String description2 =
                                                            //       desc2Controller.text
                                                            //           .trim();

                                                            //   // FirebaseFirestore.instance
                                                            //   //     .collection("users")
                                                            //   //     .doc(snapshot
                                                            //   //         .data!.docs[index].id)
                                                            //   //     .update(newUserMap = {
                                                            //   //       "Title": title2,
                                                            //   //       "Description":
                                                            //   //           description2
                                                            //   //     });
                                                            // });
                                                          },
                                                          icon: const Icon(
                                                              Icons.update),
                                                          color: Colors.white,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    widget
                                                                        .userID!)
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .delete();
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Category : (${newUserMap["Category"]})",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Desciption : ${newUserMap["Description"]}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MaterialButton(
                                                    shape:
                                                        BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    minWidth: 1000,
                                                    elevation: 0,
                                                    // color: const Color.fromARGB(
                                                    //     255, 255, 202, 26),
                                                    onPressed: () {
                                                      value.statusUpdate(
                                                          status,
                                                          snapshot.data!
                                                              .docs[index].id,
                                                          widget.userID!);
                                                    },
                                                    child: const Text("Done"))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                );
                              },
                            ));
                          } else {
                            return const Text("Database is Empty!!");
                          }
                        } else {
                          return const CircularProgressIndicator.adaptive();
                        }
                      }),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
