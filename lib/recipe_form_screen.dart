import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/recipe.dart';
import 'package:recipe_app/recipe_box.dart';
import 'package:uuid/uuid.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({super.key});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  // static const String IMAGE_URL =
  //     "https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjJ8fHBpenphfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60";
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final userController = TextEditingController();
  File? _imageFile;
  String _imageError = "";

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    userController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle recette"),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: Center(
                  child: Stack(children: [
                    _imageFile == null
                        ? const Icon(
                            Icons.food_bank_outlined,
                            size: 250,
                            color: Colors.red,
                          )
                        : Image.file(
                            _imageFile!,
                            width: 250.0,
                            height: 250.0,
                            fit: BoxFit.cover,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () async {
                          await _pickImage(ImageSource.gallery);
                          setState(() {
                            _imageError = "";
                          });
                        },
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 4,
                  child: Text(
                    _imageError,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(
                    label: Text('Username'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate() &&
                          _imageFile != null) {

                        // Generating new image path
                        final directory = await getApplicationDocumentsDirectory();
                        String imagePath = "${directory.path}/${const Uuid().v1()}.png";
                        await _imageFile!.copy(imagePath);

                        Recipe recipe = Recipe(
                          titleController.value.text,
                          userController.value.text,
                          imagePath,
                          descriptionController.value.text,
                          false,
                          Random().nextInt(100),
                        );

                        RecipeBox.box?.put(recipe.key(), recipe);
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _imageError = "You must select an image";
                        });
                      }
                    },
                    child: const Text("Save")),
              )
            ],
          )),
    );
  }
}
