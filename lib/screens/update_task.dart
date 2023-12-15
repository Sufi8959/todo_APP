import 'package:flutter/material.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/model/user_model.dart';

class UpdateTaskScreen extends StatefulWidget {
  UpdateTaskScreen(this.userTask, {super.key});
  final UserTask userTask;
  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
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
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
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
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Container(
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
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    FireStoreDatabase()
                        .updateTask(widget.userTask.id, titleController.text,
                            subtitleController.text, imageIndex)
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: Text('Update Task'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
