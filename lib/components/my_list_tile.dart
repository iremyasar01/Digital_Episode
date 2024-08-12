import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
 final void Function()? OnTap;
 MyListTile({super.key, required this.icon,required this.text, required this.OnTap, });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
      color: Colors.white,
      ),
      onTap: OnTap ,
      title:Text(text) ,
    );
  }
}