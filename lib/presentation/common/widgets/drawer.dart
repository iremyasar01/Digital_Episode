
import 'package:digital_episode/presentation/common/widgets/my_list_tile.dart';
import 'package:digital_episode/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: const Color.fromARGB(255, 235, 182, 244),
      child: Column(
        children: [ const DrawerHeader
        (child: Icon(Icons.person,
        color: Colors.white,
        size: 24,),
        ),
         MyListTile(icon:Icons.home ,text: "home",  onTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const HomeScreen())) ),
        /*
        MyListTile(icon: Icons.tv, text:"WatchList",OnTap: () =>
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const WatchlistScreen())) ),
        MyListTile(text: "Favorites",icon: Icons.heart_broken,OnTap: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => const FavoritesScreen()))),
        MyListTile(text: "All Tv Shows",icon: Icons.tv_sharp,OnTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const AllTvShowsScreen()))),
        MyListTile(text: "All Movies",icon: Icons.movie,OnTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const AllMoviesScreen())) ),
        MyListTile( text: "New series",icon: Icons.tv_outlined,OnTap: () =>
        Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const NewSeriesScreen())) ),
     
*/
     
        ],
       
      ),
      );
    
  }
}