import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_todo/model/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';


class EditForm extends StatefulWidget {
final Todo todo;

EditForm( this.todo);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final titleController =  TextEditingController();

  final descController = TextEditingController();

  final _form = GlobalKey<FormState>();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller: titleController..text = widget.todo.title,
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
                              child: image == null ?  Image.file(File(widget.todo.imageUrl), fit: BoxFit.cover,) : Image.file(File(image!.path), fit: BoxFit.cover,),
                            ),
                          ),

                          SizedBox(height: 10,),
                          TextFormField(
                            controller: descController..text = widget.todo.description,
                            decoration: InputDecoration(
                                label: Text('description')
                            ),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton(
                              onPressed: () {
                                _form.currentState!.save();
                           if(image == null){
                             widget.todo.title = titleController.text.trim();
                             widget.todo.description = descController.text.trim();
                           }else{
                             widget.todo.title = titleController.text.trim();
                             widget.todo.description = descController.text.trim();
                             widget.todo.imageUrl = image!.path;
                           }

                               widget.todo.save();
                                Navigator.of(context).pop();
                              },
                              child: Text('Edit Todo')
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
