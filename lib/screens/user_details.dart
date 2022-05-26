import 'package:basic_bank_app/screens/select_user.dart';
import 'package:basic_bank_app/screens/users_screen.dart';
import 'package:basic_bank_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/user.dart';

class UserDetails extends StatelessWidget {
  final int id;
  final transferController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextStyle style= const TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.normal);

  UserDetails(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          User user = cubit.users[id];
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'User Details',
                style: TextStyle(fontSize: 25),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 130,
                      backgroundImage: AssetImage(user.image),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Name: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).buttonColor),
                        ),
                        Text(
                          user.name,
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).buttonColor),
                        ),
                        Text(
                          user.email,
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 13.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Account NO: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).buttonColor),
                        ),
                        Text(
                          '${user.id}',
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 13.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Balance: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).buttonColor),
                        ),
                        Text(
                          '${user.balance}',
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          cubit.showForm();
                        },
                        child: const Text(
                          'Transfer Money',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Visibility(
                      visible: cubit.isShow,
                      child: Form(
                        key: formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                  validator: (String ?value){
                                      if(value!.isEmpty){
                                        return 'Amount Can\'t be empty';
                                      }
                                      if(int.parse(value)>user.balance){
                                        return 'Amount can\'t be greater than balance';
                                      }
                                      return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: transferController,
                                  decoration: const InputDecoration(
                                    labelText: 'Amount to transfer...',
                                  )
                              ),

                            ),
                            const SizedBox(width: 8.0,),
                            OutlinedButton(
                              onPressed: () {
                                cubit.isShow=false;
                                if (formKey.currentState!.validate()){
                                  cubit.setTransferAmount(double.parse(transferController.text));
                                  cubit.setSenderId(id);
                                  navigateTo(context,  const SelectUserScreen());
                                }
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.person),
                                  Text('Transfer to')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
