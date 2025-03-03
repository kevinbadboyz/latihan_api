import 'package:flutter/material.dart';
import 'package:latihan_api/models/game_model.dart';
import 'package:latihan_api/param/game_param.dart';
import 'package:latihan_api/repo/game_repository.dart';
import 'package:latihan_api/response/game_create_response.dart';

class GameCreatePage extends StatefulWidget {
  GameModel? gameModel;

  GameCreatePage({super.key, this.gameModel});

  @override
  State<GameCreatePage> createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GameCreatePage> {
  final gameRepository = GameRepository();
  late Future<GameCreateResponse> futureGameCreate;
  final globayKey = GlobalKey<FormState>();
  final tecName = TextEditingController();
  final tecPrice = TextEditingController();

  String dropDownValue = 'Active';
  var listStatus = ['Active', 'Non-Active'];

  @override
  void initState() {
    // futureGameCreate = gameRepository.addGame(GameParam(name: 'Game A2', price: '125000.00'));
    if (widget.gameModel != null) {
      tecName.text = widget.gameModel!.name;
      tecPrice.text = widget.gameModel!.price;
    }
    super.initState();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.gameModel == null ? 'Form Add Game' : 'Form Update Game'),
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
                  validator: (value) => value == null || value.isEmpty
                      ? 'Masukkan nama game anda'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: tecPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text('Harga Game'),
                      hintText: 'Masukkan harga game'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Masukkan harga game anda'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.gameModel != null
                    ? DropdownButtonFormField(
                        value: widget.gameModel == null
                            ? dropDownValue
                            : widget.gameModel!.status,
                        items: listStatus
                            .map((element) => DropdownMenuItem(
                                  child: Text(element),
                                  value: element,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            dropDownValue = val!;
                            debugPrint('Value dropdown : ${val}');
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.deepPurple,
                        ),
                        dropdownColor: Colors.deepPurple.shade50,
                        decoration: InputDecoration(
                            labelText: 'Status Game',
                            prefixIcon: Icon(Icons.info)),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (widget.gameModel == null &&
                              globayKey.currentState!.validate()) {
                            futureGameCreate = gameRepository.addGame(GameParam(
                                name: tecName.text.toString(),
                                price: tecPrice.text.toString(),
                                status: dropDownValue));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Data berhasil disimpan...')));
                          } else if (globayKey.currentState!.validate()) {
                            futureGameCreate = gameRepository.updateGame(
                                GameParam(
                                    id: int.parse(
                                        widget.gameModel!.id.toString()),
                                    name: tecName.text.toString(),
                                    price: tecPrice.text.toString(),
                                    status: dropDownValue));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Data berhasil diubah...')));
                          }
                        },
                        child:
                            Text(widget.gameModel == null ? 'Simpan' : 'Ubah')),
                    OutlinedButton(
                        onPressed: () {
                          if(widget.gameModel != null){
                            GameModel newGameModel = GameModel(
                                id: int.parse(widget.gameModel!.id.toString()),
                                name: tecName.text.toString(),
                                price: tecPrice.text.toString(),
                                status: dropDownValue);
                            Navigator.pop(context, newGameModel);
                          }else{
                            Navigator.pop(context);
                          }
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
