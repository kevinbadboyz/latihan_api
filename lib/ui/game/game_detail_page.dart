import 'package:flutter/material.dart';
import 'package:latihan_api/models/game_model.dart';
import 'package:latihan_api/ui/game/game_create_page.dart';

class GameDetailPage extends StatelessWidget {
  GameModel? gameModel;
  GameDetailPage({super.key, required this.gameModel});

  @override
  Widget build(BuildContext context) {
    GameModel newGameModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(gameModel!.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              CircleAvatar(
                child: Text('#${gameModel!.id}'),
                radius: 30,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Nama Game'),
                subtitle: Text(gameModel!.name),
              ),
              ListTile(
                title: Text('Harga Game'),
                subtitle: Text(gameModel!.price),
              ),
              ListTile(
                title: Text('Status Game'),
                subtitle: Text(gameModel!.status),
              ),
              const Divider(
                thickness: 1,
              ),
              OverflowBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GameCreatePage(gameModel: gameModel)));
                        if(result != null){
                          debugPrint('Result found... ${result}');
                          GameModel newGameModel = result;
                          debugPrint('Result 2 : ${newGameModel.name}');
                        }
                      },
                      child: Text('Ubah')),
                  ElevatedButton(onPressed: () {}, child: Text('Hapus'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
