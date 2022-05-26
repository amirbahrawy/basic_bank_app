import 'package:basic_bank_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your app  lication.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => AppCubit()..createDatabase(),
    child:BlocConsumer<AppCubit,AppStates>(
      builder: (context,state){
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           fontFamily: 'sty',
           brightness: Brightness.light,
           primaryColor: Colors.green,
           primarySwatch: Colors.green,
           buttonColor: Colors.black,
           textTheme: const TextTheme(
             headline1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black),
             headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black),
           ),
           bottomNavigationBarTheme: const BottomNavigationBarThemeData(
               type: BottomNavigationBarType.fixed,
               selectedItemColor: Colors.green),
         ),

         home: const SplashScreen('Sparks Bank','assets/bank.jpg'),
       );
    },
    listener: (context,state){},
    ));

  }
}