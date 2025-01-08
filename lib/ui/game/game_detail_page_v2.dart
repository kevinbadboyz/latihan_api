import 'package:flutter/material.dart';
import 'package:latihan_api/models/game_model.dart';
import 'package:latihan_api/repo/game_repository.dart';

import 'game_create_page.dart';

class GameDetailPageV2 extends StatefulWidget {
  GameModel? gameModel;

  GameDetailPageV2({super.key, required this.gameModel});

  @override
  State<GameDetailPageV2> createState() => _GameDetailPageV2State();
}

class _GameDetailPageV2State extends State<GameDetailPageV2> {
  final gameRepository = GameRepository();
  late final Future<GameModel> futureGetGame;

  @override
  void initState() {
    futureGetGame = gameRepository.getGame(widget.gameModel!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameModel!.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
          future: futureGetGame,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      CircleAvatar(
                        child: Text(snapshot.data!.id.toString()),
                        radius: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text('Nama Game'),
                        subtitle: Text(snapshot.data!.name),
                      ),
                      ListTile(
                        title: Text('Harga Game'),
                        subtitle: Text(snapshot.data!.price),
                      ),
                      ListTile(
                        title: Text('Status Game'),
                        subtitle: Text(snapshot.data!.status),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      OverflowBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameCreatePage(
                                              gameModel: widget.gameModel,
                                            )));
                                if(result != null){
                                  debugPrint('Resul found...');
                                  GameModel x = result;
                                  futureGetGame = gameRepository.getGame(x.id);
                                }
                              },
                              child: Text('Ubah')),
                          ElevatedButton(onPressed: () {}, child: Text('Hapus'))
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
