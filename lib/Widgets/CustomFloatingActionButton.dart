import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../Models/ContactData.dart';
import 'CustomTextFormField.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final bool btnDelete;
 final List<ContactData>contacts;
 final VoidCallback? delete;
 final Function? add;
  const CustomFloatingActionButton({super.key ,  this.btnDelete=false , required this.contacts ,this.add, this.delete });

  @override
  State<CustomFloatingActionButton> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;



  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
    widget.btnDelete?
    FloatingActionButton(
      backgroundColor:const Color(0xffF93E3E),
      onPressed:  widget.delete
      ,child:const Icon(Icons.delete_sharp ,
      size: 30,
      color: Colors.white,),
    )
    : FloatingActionButton(
      backgroundColor:const Color(0xffFFF1D4),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: const Color(0xff29384D),
          builder: (BuildContext context) => SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final XFile? pickedFile =
                            await _picker.pickImage(source: ImageSource.gallery);

                            if (pickedFile != null) {
                              setState(() {
                                selectedImage = File(pickedFile.path);
                              });
                            }
                          },

                          child: Container(
                            margin: EdgeInsets.all(12),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffFFF1D4),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: selectedImage == null
                                ? Lottie.asset("assets/images/image_picker.json")
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),

                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15
                                  ),
                                  child: Text(
                                    nameController.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffFFF1D4),
                                    ),
                                  ),
                                ),
                                const Divider(color: Color(0xffFFF1D4), thickness: 2, height: 2),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15
                                    ),
                                  child: Text(
                                    emailController.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffFFF1D4),
                                    ),
                                  ),
                                ),
                                const Divider(color: Color(0xffFFF1D4), thickness: 2, height: 2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15
                                  ),
                                  child: Text(
                                    phoneController.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffFFF1D4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: "Enter User Name",
                            controller: nameController,
                            fieldType: "name",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            hintText: "Enter User Email",
                            controller: emailController,
                            fieldType: "email",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            hintText: "Enter User Phone",
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            fieldType: "phone",
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: const Color(0xffFFF1D4),
                        minimumSize: const Size.fromHeight(60),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                           final newContact = ContactData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              inputImage: selectedImage,
                            );
                           widget.add?.call(newContact);
                            nameController.clear();
                            emailController.clear();
                            phoneController.clear();
                            selectedImage = null;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Enter User",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff29384D),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      }

      ,child:const Icon(Icons.add , size: 30,),
    )
    ;
  }
}
