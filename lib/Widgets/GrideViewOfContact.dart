import 'package:flutter/material.dart';

import '../Models/ContactData.dart';

class CustomGridView extends StatefulWidget {
  final List<ContactData>contacts;

  const CustomGridView({super.key , required this.contacts});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding:EdgeInsets.only(top: 27, left: 16, right: 16),
      gridDelegate:
         const SliverGridDelegateWithFixedCrossAxisCount
      (crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.65,) ,
      itemBuilder: (_,index){
        final contact =widget.contacts[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xffFFF1D4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex:6,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.file(contact.inputImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color:const Color(0xffFFF1D4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          contact.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff29384D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                         const Icon(Icons.email, size: 18, color: Color(0xff29384D)),
                         const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              contact.email,
                              style:const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff29384D),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 18, color: Color(0xff29384D)),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              contact.phone,
                              style:const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff29384D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.contacts.removeAt(index);
                      });
                    },
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_sharp, size: 18
                            , color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: widget.contacts.length,
    );
  }
}
