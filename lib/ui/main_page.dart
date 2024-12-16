import 'package:flutter/material.dart';
import 'package:latihan_api/ui/homepage.dart';
import 'package:latihan_api/ui/upload_image_page.dart';
import 'package:latihan_api/ui/user_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan API Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
            },
            title: Text('GAME'),
            subtitle: Text('CRUD Game'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage()));
            },
            title: Text('User'),
            subtitle: Text('CRUD User'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UploadImagePage()));
            },
            title: Text('Upload Image'),
            subtitle: Text('Upload Image From Image'),
          )
        ],
      ),
    );
  }
}
