
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/services/todo_service.dart';
import 'package:todoapp/widgets/todo_item.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final ToDoServie _toDoServie = ToDoServie();
  final _todoController = TextEditingController();

  // FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // db.collection('todos').snapshots().listen((snapshot) {});
    // final CollectionReference _todosref =
    //     FirebaseFirestore.instance.collection("todos");
    return StreamBuilder<QuerySnapshot>(
        stream: _toDoServie.todoStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var docs = snapshot.data?.docs ?? [];
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: tdBGColor,
            appBar: _BuiltAppBar(),
            body: Column(
              
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  // color: Color(0xffAAF0D1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('TO-DO',style: TextStyle(fontSize: 46,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, Index) {
                          // DocumentReference docRef =
                          //     _todosref.doc(docs[Index].id);
                          Map<String, dynamic> data =
                              docs[Index].data() as Map<String, dynamic>;
                          return TodoItem(
                            onDeleteItem: (value) {
                              // docRef.delete();

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Are You Sure?'),
                                      content: Text('Do You Want To Exit'),
                                      actions: [
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.of(context).pop();
                                            }),
                                            child: Text('NO')),
                                        TextButton(
                                            onPressed: (() {
                                              _toDoServie
                                                  .deleteTodo(docs[Index].id);
                                                   Navigator.of(context).pop();
                                            }),
                                            child: Text('YES')),
                                      ],
                                    );
                                  });
                            },
                            onToDoChanged: (value) {
                              // docRef.update({'isDone': value});
                              _toDoServie.updateTodo(docs[Index].id, value!);
                            },
                            todo: ToDo(
                              id: '1',
                              title: data['title'],
                              isDone: data['isDone'],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      right: 24,
                      child: FloatingActionButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: 100,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _todoController,
                                    decoration: InputDecoration(
                                        //  contentPadding: EdgeInsets.all(0),
                                        hintText: 'Type something'),
                                  ),
                                  ElevatedButton(
                                      onPressed: (() {
                                        String title = _todoController.text;
                                        _toDoServie.addTodo(title);
                                        // _todosref.add({'title':title,'isDone':false});
                                        Navigator.of(context).pop();
                                        _todoController.clear();
                                      }),
                                      child: Text('submit'))
                                ],
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.add, size: 36),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

AppBar _BuiltAppBar() {
  return AppBar(
    backgroundColor: tdBGColor,
    title: Row(
      children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        )
      ],
    ),
  );
}
