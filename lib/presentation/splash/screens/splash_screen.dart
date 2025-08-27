import 'package:digital_episode/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

 Future.delayed(const Duration(seconds: 2), (){

// ignore: use_build_context_synchronously
Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: 
  (_)=> const HomeScreen(),));
  });
  }
  @override
 void dispose(){
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  super.dispose();
 }
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 168, 48, 189), Color.fromARGB(255, 78, 31, 208), Color.fromARGB(255, 232, 227, 227)], ),

      ),
      child:const Center(
      
        child: Image(
          image: AssetImage("assets/splashScreen.png"),),
      ),
      ),
    );
  }
}