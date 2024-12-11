import 'package:flutter/material.dart';
import 'package:latihan_api/models/game_model.dart';
import 'package:latihan_api/param/game_param.dart';
import 'package:latihan_api/repo/game_repository.dart';
import 'package:latihan_api/response/game_create_response.dart';

class GameCreatePage extends StatefulWidget {
  GameModel? gameModel;
  GameCreatePage({super.key, required this.gameModel});

  @override
  State<GameCreatePage> createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GameCreatePage> {
  final gameRepository = GameRepository();
  late Future<GameCreateResponse> futureGameCreate;
  final globayKey = GlobalKey<FormState>();
  final tecName = TextEditingController();
  final tecPrice = TextEditingController();

  @override
  void initState() {
    // futureGameCreate = gameRepository.addGame(GameParam(name: 'Game A2', price: '125000.00'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameModel == null ? 'Form Add Game' : 'Form Update Game'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: globayKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tecName,
                  decoration: InputDecoration(
                      label: Text('Nama Game'), hintText: 'Masukkan nama game'),
                  validator: (value)=> value == null || value.isEmpty ? 'Masukkan nama game anda' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: tecPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text('Harga Game'), hintText: 'Masukkan harga game'),
                  validator: (value)=> value == null || value.isEmpty ? 'Masukkan harga game anda' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if(globayKey.currentState!.validate()){
                            futureGameCreate = gameRepository.addGame(GameParam(
                                name: tecName.text.toString(),
                                price: tecPrice.text.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Data berhasil disimpan...')));
                          }
                        },
                        child: Text('Simpan')),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Batal')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
