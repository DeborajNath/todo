import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/constants/dimensions.dart';
import 'package:todo_list/constants/routes.dart';
import 'package:todo_list/provider/task_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    void showAddTaskDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Text("Add New task"),
                const Spacer(),
                InkWell(
                    onTap: () {
                      titleController.clear();
                      descriptionController.clear();
                      RoutingService.goBack(context);
                    },
                    child: const Icon(Icons.cancel)),
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
                const Gap(20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Add description of the task",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      Provider.of<TaskProvider>(context, listen: false).addTask(
                          titleController.text, descriptionController.text);
                      titleController.clear();
                      descriptionController.clear();
                      RoutingService.goBack(context);
                    }
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          );
        },
      );
    }

    void showEditTaskDialog(
        int index, String initialTitle, String initialDescription) {
      titleController.text = initialTitle;
      descriptionController.text = initialDescription;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Text("Edit task"),
                const Spacer(),
                InkWell(
                    onTap: () {
                      titleController.clear();
                      descriptionController.clear();
                      RoutingService.goBack(context);
                    },
                    child: const Icon(Icons.cancel)),
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
                const Gap(20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Task Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .editTask(index, titleController.text,
                              descriptionController.text);
                      titleController.clear();
                      descriptionController.clear();
                      RoutingService.goBack(context);
                    }
                  },
                  child: const Text("Update"),
                )
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        shape: const CircleBorder(),
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
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              final isCompleted = task["completed"] as bool;
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
                            task["title"]!,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          )),
                          subtitle: Center(
                            child: Text(
                              task["description"]!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                          ),
                          trailing: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showEditTaskDialog(index, task["title"]!,
                                      task["description"]!);
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: green,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .deleteTask(index);
                                },
                                child: Icon(
                                  Icons.delete_forever,
                                  color: red,
                                ),
                              ),
                            ],
                          ),
                          leading: Checkbox(
                            value: isCompleted,
                            onChanged: (value) {
                              Provider.of<TaskProvider>(context, listen: false)
                                  .toggleTaskCompletion(index);
                            },
                          ),
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
