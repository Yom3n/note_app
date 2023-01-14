class NoteEntity {
  int? id;
  late String name;
  late String date;
  late String body;
  late int state;

  NoteEntity({
    this.id,
    required this.name,
    required this.date,
    required this.state,
    this.body = '',
  });

  //If there would be more entities,
  // would be good to migrate to json_serializable
  NoteEntity.fromMap(Map<String, Object?> map) {
    id = map['id'] as int?;
    name = map['name'] as String;
    date = map['date'] as String;
    body = map['body'] as String;
    state = map['state'] as int;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'name': name,
      'date': date,
      'body': body,
      'state': state,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
