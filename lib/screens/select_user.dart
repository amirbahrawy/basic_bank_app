import 'package:basic_bank_app/screens/splash.dart';
import 'package:basic_bank_app/screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/components.dart';
class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
              return Scaffold(
                appBar:AppBar(
                  title: const Text(
                    'Select The Receiving User ',
                    style: TextStyle(fontSize: 25),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                body: ListView.separated(
                    itemBuilder: (context, index) => GestureDetector(
                        onTap:() {
                          cubit.setReceiverId(index);
                          navigateReplacementTo(context, const SplashScreen('Money has been transferred successfully','assets/success.png'));
                        },
                        child: buildUserItem(context, cubit.users[index])),
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey,
                    ),
                    itemCount: cubit.users.length),
              );
        },
        listener: (context, state) {});
  }
}