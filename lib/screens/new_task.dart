import 'package:flutter/material.dart';
import 'package:todo_app/data/firestore.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  int imageIndex = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      focusNode: _focusNode1,
                      controller: titleController,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Title",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              width: 1, color: Colors.greenAccent.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.greenAccent.shade400, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'No title added';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      maxLines: 3,
                      focusNode: _focusNode2,
                      controller: subtitleController,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Subtitle",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              width: 1, color: Colors.greenAccent.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.greenAccent.shade400, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'No subtitle added';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      imageIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: imageIndex == index
                              ? Colors.greenAccent.shade700
                              : Colors.greenAccent.shade200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'lib/assets/images/${index}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 35,
                width: 120,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent.shade400),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FireStoreDatabase()
                          .AddNewTask(titleController.text,
                              subtitleController.text, imageIndex)
                          .then(
                            (value) => Navigator.of(context).pop(),
                          );
                    }
                  },
                  child: Text('Add Task'),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 35,
                width: 120,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
