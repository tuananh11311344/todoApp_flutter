import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/components/pages/Home/AddNoteScreen.dart';
import 'package:todo_app/src/database/database.dart';
import 'package:todo_app/src/models/task_model.dart';
import 'package:todo_app/src/routes/DrawerNavigaton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Task>> _taskList;

  final DateFormat _dateFormatter = DateFormat("dd - MM - yyyy");

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text(
            "Todo App SQLite",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder<List<Task>>(
            future: _taskList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final taskList = snapshot.data!;
                if (taskList.isEmpty) {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .error_outline, 
                        color: Colors.red,
                        size: 30, 
                      ),
                      Text(
                        'Task is empty',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }
                final int completeTaskCount =
                    taskList.where((Task task) => task.status == 1).length;
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            // Progress Indicator
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              value: taskList.isEmpty
                                  ? 0
                                  : completeTaskCount / taskList.length,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.blue),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "My Tasks",
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "$completeTaskCount of ${taskList.length} tasks",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (context, index) {
                          Task task = taskList[index];
                          return Dismissible(
                            direction: DismissDirection.horizontal,
                            background: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "This task is delete",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              setState(() {
                                taskList.removeAt(index);
                                DatabaseHelper.instance.deleteTask(task.id!);
                                _updateTaskList();
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => AddNoteScreen(
                                      updateTaskList: _updateTaskList,
                                      task: task,
                                    ),
                                  ),
                                );
                              },
                              child: AnimatedContainer(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: task.status == 1
                                      ? Colors.green.withOpacity(0.5)
                                      : task.priority == 'Low'
                                          ? Colors.blue.withOpacity(0.5)
                                          : task.priority == 'Medium'
                                              ? Colors.yellow.withOpacity(0.5)
                                              : task.priority == 'High'
                                                  ? Colors.red.withOpacity(0.5)
                                                  : Colors.blue.withOpacity(0.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      offset: const Offset(0, 4),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                duration: const Duration(milliseconds: 600),
                                child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        task.status = task.status == 0 ? 1 : 0;
                                        DatabaseHelper.instance.updateTask(task);
                                        _updateTaskList();
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 600),
                                      decoration: BoxDecoration(
                                        color: task.status == 0
                                            ? Colors.white
                                            : Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: task.status == 0
                                            ? Colors.grey
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 5, top: 3),
                                    child: Text(
                                      task.name!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.description!,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 92, 84, 84),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                            top: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_dateFormatter.format(task.date!)} (${task.priority})',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 92, 84, 84),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No tasks available'),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => AddNoteScreen(
                  updateTaskList: _updateTaskList,
                ),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        drawer: const Drawernavigaton(),
      ),
    );
  }
}
