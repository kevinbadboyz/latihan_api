import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan_api/param/user_param.dart';
import 'package:latihan_api/repo/user_repository.dart';
import 'package:latihan_api/response/user_create_response.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? file;
  final ImagePicker picker = ImagePicker();
  final userRepository = UserRepository();
  late final Future<UserCreateResponse> futureUserCreate;

  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        file = File(image.path);
      } else {
        debugPrint('No Image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Upload image');
        },
        child: Icon(Icons.camera_alt_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            file == null
                ? Text('Please pick a image to upload')
                : Image.file(file!),
            const SizedBox(
              height: 20,
            ),
            file == null
                ? ElevatedButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text('Pick Image'))
                : ElevatedButton(
                    onPressed: () {
                      futureUserCreate = userRepository.addUser(UserParam(
                          firstName: 'Emma',
                          lastName: 'Miller',
                          gender: 'Female',
                          image: file));
                    },
                    child: Text('Upload Image')),
            Text(''),
          ],
        ),
      ),
    );
  }
}
