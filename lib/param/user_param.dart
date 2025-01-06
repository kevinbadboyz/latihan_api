import 'dart:io';

import 'package:dio/dio.dart';

class UserParam {
  final String firstName;
  final String lastName;
  final String gender;
  final File? image;

  UserParam(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.image});

  Future<FormData> toJson() async {
    File? file;

    if (this.image != null) {
      file = this.image!;
    }

    return FormData.fromMap({
      'firstName' : this.firstName,
      'lastName' : this.lastName,
      'gender' : this.gender,
      'image': await MultipartFile.fromFile(file!.path,
          filename: file.path.split('/').last),
    });
  }
}
