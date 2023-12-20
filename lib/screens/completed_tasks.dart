import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_tutorial/screens/status_provider.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key, required this.userID, required this.isDone});
  final String? userID;
  final bool isDone;
  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
        builder: (context, value, child) => Scaffold(
              bottomNavigationBar: SizedBox(
                width: double.infinity,
                height: 60,
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.home,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 40,
                            ),
                          ),
                          Consumer<StatusProvider>(
                            builder: (context, value, child) => IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.checklist_sharp,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                size: 40,
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
              appBar: AppBar(
                title: const Text("Completed Tasks"),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(widget.userID!)
                          .where("Status", isEqualTo: true)
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
                                      //     // const Color.fromARGB(255, 255, 202, 26),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                                      "Task logo"]),
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
                                                        // IconButton(
                                                        //   onPressed: () {
                                                        //     String id = snapshot
                                                        //         .data!.docs[index].id;
                                                        //     Navigator.of(context).push(
                                                        //         MaterialPageRoute(
                                                        //             builder:
                                                        //                 (context) =>
                                                        //                     UpdateTask(
                                                        //                       id: id,
                                                        //                       userID: widget
                                                        //                           .userID!,
                                                        //                     )));
                                                        //     // setState(() {
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
                                                        //   },
                                                        //   icon:
                                                        //       const Icon(Icons.update),
                                                        //   color: Colors.white,
                                                        // ),
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
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Category : (${newUserMap["Category"]})",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
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
                                                    child:
                                                        const Text("Add again"))
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
                ),
              ),
            ));
  }
}
