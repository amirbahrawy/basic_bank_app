import 'package:basic_bank_app/cubit/cubit.dart';
import 'package:basic_bank_app/cubit/states.dart';
import 'package:basic_bank_app/screens/splash.dart';
import 'package:basic_bank_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_details.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          if (cubit.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              body: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                      onTap:() {
                          navigateTo(context, UserDetails(index));
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
          }
        },
        listener: (context, state) {});
  }
}
