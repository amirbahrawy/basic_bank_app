import 'package:basic_bank_app/screens/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/home_layout.dart';
import '../models/transfer.dart';
import '../models/user.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    /*current widget*/
    /*widget : the next widget */
    MaterialPageRoute(builder: (context) => widget));
void navigateReplacementTo(context, widget) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        widget), (Route<dynamic> route) => false);


Widget buildUserItem(context, User user) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage(user.image),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Balance:',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            '\$${user.balance}',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        user.email,
        style: const TextStyle(color: Colors.black54, fontSize: 15.0),
      ),
    ),
  );
}

Widget userBuilder(List<User> users,Function onTap) {
  return ListView.separated(
      itemBuilder: (context, index) => GestureDetector(
          onTap:onTap(),
          child: buildUserItem(context, users[index])),
      separatorBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
      itemCount: users.length);
}

Widget buildTransferItem(context, Transfer transfer) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  transfer.senderName,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(transfer.senderImage),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '\$${transfer.senderBalance}',
                style: const TextStyle(fontSize: 16.0, color: Colors.red),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Icon(Icons.arrow_forward,
                  size: 50, color: Colors.deepPurpleAccent),
              Text(
                '\$ ${transfer.amount}',
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  transfer.receiverName,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(transfer.receiverImage),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '\$${transfer.receiverBalance} ',
                style: const TextStyle(fontSize: 16.0, color: Colors.green),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget transferBuilder(List<Transfer> transfers) {
  return ListView.separated(
      itemBuilder: (context, index) =>
          buildTransferItem(context, transfers[index]),
      separatorBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
      itemCount: transfers.length);
}
