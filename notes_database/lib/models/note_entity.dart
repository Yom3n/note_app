import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  late final int? id;
  late final String name;
  late final String? date;
  late final String body;

  // 1: draft
  // 2: Live
  // 3: Archived
  late final int state;

  NoteEntity({
    this.id,
    required this.name,
    this.date,
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

  @override
  List<Object?> get props => [
        id,
        name,
        date,
        state,
        body,
      ];
}
