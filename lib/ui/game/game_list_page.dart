import 'package:flutter/material.dart';
import 'package:latihan_api/ui/game/game_detail_page_v2.dart';

import '../../models/game_model.dart';
import '../../repo/game_repository.dart';
import 'game_create_page.dart';
import 'game_detail_page.dart';

class GameListPage extends StatefulWidget {
  const GameListPage({super.key});

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  final gameRepository = GameRepository();
  late Future<List<GameModel>> futureGameModel;

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
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GameCreatePage()))
              .then((_) {
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
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () {
                      debugPrint('Item : ${snapshot.data![index].name}');
                      GameModel gameModel = snapshot.data![index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GameDetailPage(gameModel: gameModel)));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => GameDetailPageV2(
                      //               gameModel: gameModel,
                      //             )));
                    },
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
