import 'package:hive/hive.dart';
part 'todo.g.dart';


@HiveType(typeId: 0)
class Todo extends HiveObject{

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String imageUrl;


  Todo({
   required this.title,
   required this.description,
   required this.imageUrl,
  });



}