import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_api/models/user_model.dart';
import 'package:latihan_api/param/user_param.dart';
import 'package:latihan_api/response/user_create_response.dart';

class UserRepository {
  Future<List<UserModel>> getUsers() async {
    try {
      var response = await Dio().get('http://54.243.8.93:8000/api/users');
      debugPrint('GET All User Response : ${response.data}');
      List list = response.data;
      List<UserModel> listUser =
          list.map((element) => UserModel.fromJson(element)).toList();
      return listUser;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCreateResponse> addUser(UserParam userParam) async {
    File? file;

    if (userParam.image != null) {
      file = userParam.image!;
    }

    FormData formData = FormData.fromMap({
      'firstName': userParam.firstName,
      'lastName': userParam.lastName,
      'gender': userParam.gender,
      'image': await MultipartFile.fromFile(file!.path,
          filename: file.path.split('/').last),
    });
    try {
      var response =
          await Dio().post('http://54.243.8.93:8000/api/users', data: userParam.toJson());
      debugPrint('POST Response : ${response.data}');
      return UserCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
