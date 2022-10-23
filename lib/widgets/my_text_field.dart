import 'package:beehive/widgets/colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
 final TextInputType inputType;
 final String headText;
 final TextEditingController? controller;
 const MyTextField({Key? key,required this.inputType,required this.headText,this.controller}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          widget.headText,
          style:const TextStyle(
            fontFamily: "Cario",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
         const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300,),
            ),
            child: TextFormField(
              keyboardType:widget.inputType ,
              controller: widget.controller,
              style: TextStyle(
                fontFamily: "Cario",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: blkColor,
              ),
              decoration:const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter",
                hintStyle: TextStyle(
                  fontFamily: "Cario",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 13, 15, 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
