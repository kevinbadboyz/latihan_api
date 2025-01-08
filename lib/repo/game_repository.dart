import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_api/models/game_model.dart';
import 'package:latihan_api/param/game_param.dart';
import 'package:latihan_api/response/game_create_response.dart';

class GameRepository {
  // Future<List<GameModel>> getGames() async {
  //   try {
  //     var response = await Dio().get('https://voucher.crabytech.com/api/game/');
  //     debugPrint('Response : ${response.data}');
  //     List list = response.data;
  //     List<GameModel> listGameModel =
  //         list.map((element) => GameModel.fromJson(element)).toList();
  //     return listGameModel;
  //   } on Exception catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<List<GameModel>> fetchGames() async {
    try {
      List<GameModel> listGame = [];
      // var response = await Dio().get('https://voucher.crabytech.com/api/game/');
      var response = await Dio().get('http://54.243.8.93:8000/api/games');
      // var response = await Dio().get('http://10.0.2.2:8000/api/games');
      debugPrint('Response Game : ${response.data}');

      List list = response.data;
      for (var json in list) {
        GameModel gameModel = GameModel.fromJson(json);
        listGame.add(gameModel);
      }
      return listGame;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<GameCreateResponse> addGame(GameParam gameParam) async {
    try {
      // var response = await Dio().post('https://voucher.crabytech.com/api/game/', data: gameParam.toJson());
      var response = await Dio().post('http://54.243.8.93:8000/api/games', data: gameParam.toJson());
      debugPrint('POST Game : ${response.data}');
      return GameCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<GameCreateResponse> updateGame(GameParam gameParam) async {
    try {
      var response = await Dio().put('http://54.243.8.93:8000/api/game/${gameParam.id}',
          data: gameParam.toJson());
      debugPrint('PUT Game : ${response.data}');
      return GameCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<GameModel> getGame(int id) async{
    try{
      var response = await Dio().get('http://54.243.8.93:8000/api/game/${id}');
      debugPrint('GET Game : ${response.data}');
      return GameModel.fromJson(response.data);
    }on DioException catch(e){
      throw Exception(e);
    }
  }
}
