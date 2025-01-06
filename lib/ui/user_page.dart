import 'package:flutter/material.dart';
import 'package:latihan_api/repo/user_repository.dart';

import '../models/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final userRepository = UserRepository();
  late final Future<List<UserModel>> futureUsers;
  String blankImage =
      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg';

  @override
  void initState() {
    futureUsers = userRepository.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of User'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    UserModel userModel = snapshot.data![index];
                    return ListTile(
                      // leading: userModel.image != null
                      //     ? CircleAvatar(
                      //         backgroundImage: NetworkImage(userModel.image!),
                      //       )
                      //     : CircleAvatar(
                      //         backgroundImage: NetworkImage(blankImage),
                      //       ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(userModel.image != null
                            ? userModel.image!
                            : blankImage),
                      ),
                      title:
                          Text('${userModel.firstName} ${userModel.lastName}'),
                      subtitle: Text(userModel.gender),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                  itemCount: snapshot.data!.length);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
