import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:basic_bank_app/cubit/cubit.dart';
import 'package:basic_bank_app/layout/home_layout.dart';
import 'package:basic_bank_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/states.dart';

class SplashScreen extends StatefulWidget {
  final String title;
  final String imagePath;

  const SplashScreen(this.title, this.imagePath, {Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState(title, imagePath);
}

class _SplashScreenState extends State<SplashScreen> {
  final String title, imagePath;
  _SplashScreenState(this.title, this.imagePath);

  @override
  void initState() {
    super.initState();
    goTo();
  }

  void goTo() async {
    if (title.compareTo('Money has been transferred successfully') == 0) {
      AppCubit cubit = AppCubit.get(context);
      await cubit.updateUsers();
      await cubit.getUsersFromDatabase();
      await cubit.insertTransfersToDB();
      await Future.delayed(const Duration(milliseconds: 1000),(){});
      navigateReplacementTo(context, const HomeLayout());
    }
    else{
      await Future.delayed(const Duration(milliseconds: 2000),(){});
      navigateReplacementTo(context, const HomeLayout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(backgroundImage: AssetImage(imagePath),radius: 150,),
                  ),
                  const SizedBox(height: 10,),
                  Text(title,style: const TextStyle(fontSize: 35,color: Colors.green),maxLines: 2,textAlign: TextAlign.center,),

                ],),
            ),
          );
    },
    listener: (context,state){} );
  }
}
