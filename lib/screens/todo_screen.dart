import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_todo/model/todo.dart';
import 'package:hive_todo/screens/add_form.dart';
import 'package:hive_todo/screens/edit_form.dart';
import 'package:hive_flutter/hive_flutter.dart';



class TodoScreen extends StatefulWidget {


  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {


 @override
  void dispose() {
  Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<Box<Todo>>(
          valueListenable: Hive.box<Todo>('todos').listenable(),
          builder: (context, box, child){
            final todos = box.values.toList().cast<Todo>();
         return todos.length == 0 ? Center(child: Text('Add some Todo'),) : ListView.builder(
           itemCount: todos.length,
             itemBuilder: (context, index){
               return ExpansionTile(
                 title: Text(todos[index].title),
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             Container(
                         height: 100,
                         width: 100,
                         child: Image.file(File(todos[index].imageUrl))),
                             Text(todos[index].description),
                           ],
                         ),
                       ),
                       Container(
                         width: 150,
                         child: Row(
                           children: [
                             TextButton(
                                 onPressed: (){
                                   Get.to(() => EditForm(todos[index]), transition: Transition.leftToRight);
                                 },
                                 child: Icon(Icons.edit)
                             ),
                             TextButton(
                                 onPressed: () async{
                                await todos[index].delete();
                                 },
                                 child: Icon(Icons.delete)
                             )
                           ],
                         ),
                       )

                     ],
                   )
                 ],
               );
             });
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context) => AddForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
