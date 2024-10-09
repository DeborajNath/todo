import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/constants/dimensions.dart';
import 'package:todo_list/constants/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> tasks = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void addtask(String title, String description) {
    setState(() {
      tasks.add({
        "title": title,
        "description": description,
      });
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void editTask(int index) {
    titleController.text = tasks[index]["title"]!;
    descriptionController.text = tasks[index]["description"]!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text("Edit task"),
              Spacer(),
              InkWell(
                  onTap: () {
                    titleController.clear();
                    descriptionController.clear();
                    RoutingService.goBack(context);
                  },
                  child: Icon(Icons.cancel)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Gap(20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Task Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Gap(10),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    setState(() {
                      tasks[index] = {
                        "title": titleController.text,
                        "description": descriptionController.text
                      };
                    });
                    titleController.clear();
                    descriptionController.clear();
                    RoutingService.goBack(context);
                  }
                },
                child: Text("Update"),
              )
            ],
          ),
        );
      },
    );
  }

  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text("Add New task"),
              Spacer(),
              InkWell(
                  onTap: () {
                    titleController.clear();
                    descriptionController.clear();
                    RoutingService.goBack(context);
                  },
                  child: Icon(Icons.cancel)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Add Title of the task",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Gap(20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Add description of the task",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Gap(10),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    addtask(titleController.text, descriptionController.text);
                    titleController.clear();
                    descriptionController.clear();
                    RoutingService.goBack(context);
                  }
                },
                child: Text("Add"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        shape: CircleBorder(),
        onPressed: () {
          showAddTaskDialog();
        },
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: black,
        centerTitle: true,
        title: Text(
          "TODO-List",
          style: TextStyle(
              color: white,
              fontSize: 24 * Dimensions.heightF(context),
              fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [black, grey, black])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Center(
                          child: Text(
                        tasks[index]["title"]!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      subtitle: Center(
                        child: Text(
                          tasks[index]["description"]!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              editTask(index);
                            },
                            child: Icon(
                              Icons.edit,
                              color: red,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              deleteTask(index);
                            },
                            child: Icon(
                              Icons.delete_forever,
                              color: red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
