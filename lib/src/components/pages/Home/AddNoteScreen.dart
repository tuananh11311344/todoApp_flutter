import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/database/database.dart';
import 'package:todo_app/src/models/task_model.dart';
import 'package:todo_app/src/components/pages/Home/home.dart';

class AddNoteScreen extends StatefulWidget {
  int? id;
  final Task? task;
  final Function? updateTaskList;

  AddNoteScreen({super.key, this.task, this.updateTaskList, this.id});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  String? _priority = 'Low';
  String btnText = 'Add Task';
  String titleText = 'Create Task';
  String btnDelete = '';
  DateTime _date = DateTime.now();
  String _name = '';
  String _description = '';

  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('dd - MM - yyyy');

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _name = widget.task!.name ?? '';
      _date = _date = widget.task!.date!;
      _priority = widget.task!.priority!;
      _description = widget.task!.description!;

      setState(() {
        btnText = "Update Task";
        titleText = "Update Task";
        btnDelete = "Delete Task";
      });
    } else {
      setState(() {
        btnText = "Add Task";
        titleText = "Create Task";
      });
    }
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Task task = Task(
          name: _name,
          description: _description,
          date: _date,
          priority: _priority);

      if (widget.task == null) {
        task.status = 0;
        await DatabaseHelper.instance.insertTask(task);
        var a = await DatabaseHelper.instance.getAllTasks();
        // print(a);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Home()));
      } else {
        task.id = widget.task!.id;
        task.status = widget.task!.status;
        DatabaseHelper.instance.updateTask(task);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Home()));
      }
      widget.updateTaskList!();
      // print(task.toString());
    }
  }

  _deleteTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notification"),
          content: const Text("Do you really want to delete this Task?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                // Thực hiện xóa task và đóng hộp thoại
                DatabaseHelper.instance.deleteTask(widget.task!.id!);
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
                widget.updateTaskList!();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .unfocus(); //khi bấm vào màn hình sẽ bỏ focus input
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => const Home()));
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(titleText,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 35,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Task Name",
                              labelStyle: const TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (input) {
                              input!.trim().isEmpty
                                  ? "Please enter a task name"
                                  : null;
                              return null;
                            },
                            onSaved: (input) {
                              _name = input!;
                            },
                            initialValue: _name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle: const TextStyle(
                                  fontSize: 18,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (input) {
                              input!.trim().isEmpty
                                  ? "Please enter a description"
                                  : null;
                              return null;
                            },
                            onSaved: (input) {
                              _description = input!;
                            },
                            initialValue: _description,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            readOnly: true,
                            controller: _dateController,
                            onTap: _handleDatePicker,
                            decoration: InputDecoration(
                              labelText: "Date",
                              labelStyle: const TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: const Icon(Icons.date_range),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownButtonFormField(
                            value: _priority,
                            isDense: true,
                            items: _priorities.map((priority) {
                              return DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  priority,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              );
                            }).toList(),
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                labelText: 'Priority',
                                labelStyle: const TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (input) {
                              _priority == null
                                  ? "Please select a priority level"
                                  : null;
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _priority = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(top: 20),
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.withOpacity(0.8),
                                foregroundColor: Colors.white),
                            onPressed: _submit,
                            child: Text(
                              btnText,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        widget.task != null
                            ? Container(
                                margin: const EdgeInsetsDirectional.only(top: 20),
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red.withOpacity(0.8),
                                      foregroundColor: Colors.white),
                                  onPressed: _deleteTask,
                                  child: Text(
                                    btnDelete,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
