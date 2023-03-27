
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const TodoItem({Key? key,required this.todo,required this.onDeleteItem,required this.onToDoChanged}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
      onTap: () {
        // print('Click on to-do item');
        onToDoChanged(todo.isDone?false:true);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tileColor: Colors.white,
      leading: Icon(
      todo.isDone?  Icons.check_box:Icons.check_box_outline_blank,
        color: tdBlue,
      ),
      title: Text(
        todo.title!,
        style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration :todo.isDone? TextDecoration.lineThrough:TextDecoration.none,
            ),
      ),
      trailing: Container(
        height: 35,
        width: 35,
        decoration:
            BoxDecoration(color: tdRed, borderRadius: BorderRadius.circular(5)),
        child: IconButton(
          color: Colors.white,
          iconSize: 18,
          icon: Icon(Icons.delete),
          onPressed: (() {
            // print('Clicked on delete item');
            onDeleteItem(todo.id);
          }),
        ),
      ),
    ));
  }
}
