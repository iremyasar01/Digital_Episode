
//import 'package:episode_new/widgets/navigation_drawer.dart';
//import 'package:episode_new/widgets/sidebar.dart';
import 'package:episode_new/widgets/drawer.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSelected= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: const MyDrawer(),
      //önce appbar
     appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 220, 179, 228),
      title: const Text("Episode App",
     style: TextStyle(color: Color.fromARGB(255, 65, 9, 73)),),
     //leading: IconButton(icon: const Icon(Icons.menu),
     //onPressed: (){
      
      
/*
      setState(() {
        isSelected =!isSelected;
        if(isSelected = true){
          Navigator.push(
          context, MaterialPageRoute(
        builder: (context)=> const Sidebar(),),);
        }
        else {
          Navigator.pop(context);
        }
      
       });
    */
     //}
      
     
      
     //buna tıklayınca çıkacak olanlar 
     //watchlist/ all tv shows/ all movies/new series/oturumu kapat/

   

    
     centerTitle: true,
     actions: [
     IconButton(icon: const Icon (Icons.search_rounded),
     onPressed: (){
       setState(() {
          isSelected=!isSelected;
        });
     }, ),
     const SizedBox(width: 10,),
      IconButton(icon: const Icon(Icons.notifications),
      onPressed: () {
        setState(() {
          isSelected=!isSelected;
        });
       
      },),
      const SizedBox(width:10),

        
     ],),
      
     );


   
  }
}