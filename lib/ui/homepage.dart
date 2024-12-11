import 'package:flutter/material.dart';
import 'package:latihan_api/repo/game_repository.dart';
import 'package:latihan_api/ui/game_create_page.dart';

import '../models/game_model.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final gameRepository = GameRepository();
  late Future<List<GameModel>> futureGameModel;
  GameModel? gameModel;

  @override
  void initState() {
    futureGameModel = gameRepository.fetchGames();
    super.initState();
  }

  void refreshData() {
    futureGameModel = gameRepository.fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Game'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GameCreatePage(gameModel: gameModel))).then((_) {
            setState(() {
              refreshData();
            });
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: futureGameModel,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              var game = snapshot.data!;
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  //gameModel = snapshot.data![index];
                  return Container(
                    color: snapshot.data![index].status == 'Non-Active'
                        ? Colors.grey[300]
                        : Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                          child: Text(snapshot.data![index].id.toString())),
                      title: Text(snapshot.data![index].name),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data![index].status),
                          Text(snapshot.data![index].price),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 0.5,
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:latihan_api/models/game_model.dart';
// import 'package:latihan_api/repo/data_dummy.dart';
// import 'package:latihan_api/repo/game_repository.dart';
//
// class Homepage extends StatefulWidget {
//   const Homepage({super.key});
//
//   @override
//   State<Homepage> createState() => _HomepageState();
// }
//
// class _HomepageState extends State<Homepage> {
//   final gameRepository = GameRepository();
//   final dataDummy = DataDummy();
//   List<GameModel> list = [];
//
//   @override
//   void initState() {
//     list = dataDummy.list;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //debugPrint('Data : ${list}');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('API Demo'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: ListView.separated(
//           itemCount: list.length,
//           itemBuilder: (_, index) {
//             return ListTile(
//               title: Text(list[index].name),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(list[index].price),
//                   Text(list[index].status)
//                 ],
//               ),
//             );
//           }, separatorBuilder: (BuildContext context, int index) {
//             return Divider(thickness: 1,);
//       },),
//     );
//   }
// }
