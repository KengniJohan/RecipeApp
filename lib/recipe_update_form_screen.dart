import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/recipe.dart';
import 'package:recipe_app/recipe_box.dart';
import 'package:uuid/uuid.dart';

class RecipeUpdateFormScreen extends StatefulWidget {
  const RecipeUpdateFormScreen({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeUpdateFormScreen> createState() => _RecipeUpdateFormScreenState();
}

class _RecipeUpdateFormScreenState extends State<RecipeUpdateFormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final userController = TextEditingController();
  File? _imageFile;
  String _imageError = "";
  String imagePath = "";

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        widget.recipe.imageUrl = pickedImage.path;
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    setState(() {
      titleController.text = widget.recipe.title;
      descriptionController.text = widget.recipe.description;
      userController.text = widget.recipe.user;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modification de recette"),
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
                    Hero(
                      tag: "imageRecipe${widget.recipe.title}",
                      child: widget.recipe.imageUrl.startsWith("https://") ||
                              widget.recipe.imageUrl.startsWith("http://")
                          ? CachedNetworkImage(
                              imageUrl: widget.recipe.imageUrl,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: 250.0,
                              height: 250.0,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _imageFile != null
                                  ? _imageFile!
                                  : File(widget.recipe.imageUrl),
                              width: 250.0,
                              height: 250.0,
                              fit: BoxFit.cover,
                            ),
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
                      if (formKey.currentState!.validate()) {
                        // Generating new image path
                        if (_imageFile != null) {
                          final directory =
                              await getApplicationDocumentsDirectory();
                          setState(() {
                            imagePath =
                                "${directory.path}/${const Uuid().v1()}.png";
                          });
                          await _imageFile!.copy(imagePath);
                        }

                        Recipe recipe = Recipe(
                          titleController.value.text,
                          userController.value.text,
                          _imageFile == null
                              ? widget.recipe.imageUrl
                              : imagePath,
                          descriptionController.value.text,
                          widget.recipe.isFavorited,
                          widget.recipe.favoriteCount,
                        );

                        RecipeBox.box?.put(widget.recipe.key(), recipe);
                        Navigator.pop(context);
                      } else {
                        if (_imageFile == null) {
                          setState(() {
                            _imageError = "You must select an image";
                          });
                        }
                      }
                    },
                    child: const Text("Save")),
              )
            ],
          )),
    );
  }
}
