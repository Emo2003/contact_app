import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String fieldType;
  final TextInputType keyboardType;

  const CustomTextFormField({super.key ,
    required this.hintText ,
    required this.controller ,
    required this.fieldType ,
    this.keyboardType=TextInputType.text,

  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final RegExp namePattern  = RegExp(r'^[a-zA-Z\s]+$');
  final RegExp emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,4}$');
  final RegExp phonePattern = RegExp(r'^(010|011|012|015)[0-9]{8}$');

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style:const TextStyle(fontSize: 20,
      fontWeight: FontWeight.w500 ,
      color: Color(0xffE2F4F6)),
      controller:widget.controller ,
      textInputAction:widget.fieldType=="phone"?TextInputAction.done:TextInputAction.next ,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:const TextStyle(fontSize: 16,
              fontWeight: FontWeight.w400 ,
              color: Color(0xffE2F4F6)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:const BorderSide(color: Color(0xffFFF1D4))
          ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:const BorderSide(color: Color(0xffFFF1D4))
        ),
      ),
      validator: (value){
        if (value == null || value.isEmpty ) {
          return "This Field is required";
        }
        if(widget.fieldType=="name"){
          if (value.length < 3){
            return "Name must be at least 3 characters";}
            if(!namePattern.hasMatch(value)){
              return "Name must contain only letters";
            }
            return null;
        }
         if(widget.fieldType=="email"){
           if(!emailPattern.hasMatch(value)){
             return "Enter a valid email";
           }
         }

         if(widget.fieldType=="phone"){
           if(!phonePattern.hasMatch(value)){
           return "Enter a valid Egyptian phone number";
         }}
       return null ;
      },
    );
  }
}
