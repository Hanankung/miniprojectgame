import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget scoreBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 22.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 252, 252, 252),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.0,),
          Text(
            info,style:TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
