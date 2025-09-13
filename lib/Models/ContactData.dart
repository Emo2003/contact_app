import 'dart:io';
class ContactData{
  String name;
  String email;
  String phone;
  File? inputImage;
  ContactData({required this.name,
    required this.email,
    required this.phone ,
    this.inputImage});
}