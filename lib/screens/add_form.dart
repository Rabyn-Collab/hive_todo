import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_todo/model/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';


class AddForm extends StatefulWidget {

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final titleController =  TextEditingController();

  final descController = TextEditingController();
  final _form = GlobalKey<FormState>();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
        body: Form(
          key: _form,
            child: Center(
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                              label: Text('title')
                            ),
                          ),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: () async{
                              final ImagePicker _picker = ImagePicker();
                              final selectImage = await _picker.pickImage(source: ImageSource.gallery);
                              setState(() {
                                image = File(selectImage!.path);
                              });
                            },
                            child: Container(
                              width: double.infinity,
                               height: 120,
                               child: image == null ? Center(child: Text('please select an image'),) : Image.file(File(image!.path), fit: BoxFit.cover,),
                            ),
                          ),

                          SizedBox(height: 10,),
                          TextFormField(
                            controller: descController,
                            decoration: InputDecoration(
                                label: Text('description')
                            ),
                          ),

                          SizedBox(height: 10,),
                          ElevatedButton(
                              onPressed: (){
                                _form.currentState!.save();
                       final newTodo = Todo(
                           title: titleController.text.trim(),
                           description: descController.text.trim(),
                         imageUrl: image!.path
                       );
                  Hive.box<Todo>('todos').add(newTodo);
                  Navigator.of(context).pop();
                              },
                              child: Text('Add Some')
                          )
                        ],
                      ),
                    )
                )
            )
        )
    );
  }
}
