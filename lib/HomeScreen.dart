import 'package:contact_app/Widgets/GrideViewOfContact.dart';
import 'package:contact_app/Widgets/CustomFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Models/ContactData.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactData>contacts=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const  Color(0xff29384D),
      appBar: AppBar(
        backgroundColor: const Color(0xff29384D) ,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Image.asset("assets/images/route.png",width: 120 ),
        ),
      ),
      body: SafeArea(
        child:
        Column(
          children: [
            contacts.isEmpty?Expanded(
                child: Column(
                  children: [
                    Lottie.asset("assets/images/empty_list.json",
                        fit: BoxFit.cover
                    ),
                   const  Text("There is No Contacts Added Here"
                      , style: TextStyle(fontSize: 20
                          , fontWeight: FontWeight.w500
                          , color: Color(0xffFFF1D4)),),
                  ],
                ),
              )
            :  Expanded(child: CustomGridView(contacts: contacts,)),

          ],
        ),
      ),
      floatingActionButton:
      contacts.isEmpty?
      CustomFloatingActionButton(contacts: contacts,
      add: (newContact) {
        setState(() {
          contacts.add(newContact);
        });
      },
      ):
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               CustomFloatingActionButton(
                 delete: () {
                   setState(() {
                     if (contacts.isNotEmpty) contacts.removeLast();
                   });
                 },
                contacts:contacts,
                btnDelete: true,
              ),
             const  SizedBox(height: 10,),
             contacts.length<6 ?  CustomFloatingActionButton(contacts: contacts,
               add: (newContact) {
                 setState(() {
                   contacts.add(newContact);
                 });
               },
             )
                 : const SizedBox.shrink()
            ],
          )
    );
  }
}
