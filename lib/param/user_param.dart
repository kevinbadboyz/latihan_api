import 'dart:io';

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
}
