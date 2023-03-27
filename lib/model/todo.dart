class ToDo{
  String? id;
  String? title;
  bool isDone;

  ToDo({
required this.id,
required this.title,
this.isDone = false,
  });

  static List<ToDo> todoList(){
    return[
      // ToDo(id:' 01', title:'Morning exercise', isDone: true),
      // ToDo(id:' 02', title:'Buy Groceries', isDone: true),
      // ToDo(id:' 03', title:'Check emails',),
      // ToDo(id:' 04', title:'Team meeting',),
      // ToDo(id:' 05', title:'work on mobile apps for 2 hours',),
      // ToDo(id:' 06', title:'Dinner with jenny',),
    ];
  }
}