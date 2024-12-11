import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_api/models/user_model.dart';

class UserRepository{

  Future<List<UserModel>> getUsers()async{
    try{
      var response = await Dio().get('http://54.243.8.93:8000/api/users');
      debugPrint('GET All User Response : ${response.data}');
      List list = response.data;
      List<UserModel> listUser = list.map((element)=> UserModel.fromJson(element)).toList();
      return listUser;
    } on DioException catch(e){
      throw Exception(e);
    }
  }


}