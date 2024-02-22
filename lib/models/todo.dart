class ToDo {
  final String title;
  final DateTime dateTime;
  bool isCompleted;

  ToDo( {
    this.title = '',
    DateTime? dateTime,
    this.isCompleted = false
  } ) : dateTime = dateTime ?? DateTime.now();
}