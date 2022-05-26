import 'package:basic_bank_app/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state) {
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:Text(cubit.titles[cubit.currentIndex],style: const TextStyle(fontSize: 25),),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                   BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Users'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.transfer_within_a_station_sharp), label: 'Transfers'),
                ],
              )

          );
        },
        listener: (context, state) {});
  }
}
