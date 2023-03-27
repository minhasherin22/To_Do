import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoServie{
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('todos');

  Stream<QuerySnapshot> todoStream() {
    return _collectionReference.snapshots();
  }

  Future<DocumentReference>addTodo(String title){
    return _collectionReference.add({'title':title,'isDone':false});
}
Future<void>updateTodo(String id,bool isDone){
    return _collectionReference.doc(id).update({'isDone':isDone});
}


Future<void>deleteTodo(String id){
    return _collectionReference.doc(id).delete();
}


}