import 'package:basic_bank_app/models/transfer.dart';
import 'package:basic_bank_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';
import '../screens/transfers_screen.dart';
import '../screens/users_screen.dart';
import 'states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isShow = false;
  double transferAmount = 0;
  int currentIndex = 0;
  int senderID = 0;
  int receiverID = 0;
  List<User> users = [];
  List<Transfer> transfers = [];
  List<String> titles = ['Users', 'Transfers'];
  late Database database;
  List<Widget> screens = [
    const UsersScreen(),
    const TransfersScreen(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void showForm() {
    isShow = !isShow;
    emit(AppShowFormState());
  }

  void setTransferAmount(double amount) {
    transferAmount = amount;
  }

  void setSenderId(id) {
    senderID = id;
  }

  void setReceiverId(id) {
    receiverID = id;
  }

  void createDatabase() async {
    await openDatabase('Bank.db', version: 1,
        onCreate: (Database db, version) async {
      await db.execute(userTableQuery).then((value) => print('table created'));
      await db
          .execute(transferTableQuery)
          .then((value) => debugPrint('table created')).then((value) async {
        debugPrint('Database is created');
      });

        }, onOpen: (db) async{
          debugPrint('database opened');
    }).then((value) async {
      database = value;
      emit(AppCreateDatabaseState());
      await insertUsersToDB();
      await getTransfersFromDatabase();
      debugPrint('the length is ${users.length}');
    });
  }

  Future<void> getUsersFromDatabase() async {
    await database.rawQuery('SELECT * FROM user').then((value) {
      users.clear();
      for (Map element in value) {
        User user = User(
            id: element['id'],
            name: element['name'],
            email: element['email'],
            balance: element['balance'],
            image: element['image']);
        users.add(user);
      }
      emit(AppGetDatabaseState());
    });
  }

  Future<void> insertUsersToDB() async {
    await getUsersFromDatabase();
    if(users.isEmpty){
      await database.transaction((txn) {
        var id1 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Amir bahrawy","amir@gmail.com",9000,"assets/avatar1.png")');
        var id2 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Mohamed mahmoud","mohamed@gmail.com",5000,"assets/avatar2.png")');
        var id3 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Mona salama","mona@gmail.com",7500,"assets/favatar1.png")');
        var id4 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Salma farag","salma@yahoo.com",1700,"assets/favatar2.png")');
        var id5 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Karim mansour","karim@hotmail.com",22000,"assets/avatar3.png")');
        var id6 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Malak ahmed","malakakram@gmail.com",1900,"assets/favatar3.png")');
        var id7 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("Islam eldin","islam@gmail.com",9900,"assets/avatar4.png")');
        var id8 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("wael salama","wael@gmail.com",2400,"assets/avatar5.png")');
        var id9 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("yara ahmed","yara2020@gmail.com",92000,"assets/favatar4.png")');
        var id10 = txn.rawInsert(
            'INSERT INTO user(name,email,balance,image) VALUES("aya mohamed","aya_mhmd@hotmail.com",25000,"assets/favatar5.png")');
        return id1;
      }).then((value) {
        emit(AppInsertDatabaseState());
        getUsersFromDatabase();
      } );
    }
  }

  Future<void> getTransfersFromDatabase() async {
    transfers.clear();
    await database.rawQuery('SELECT * FROM transfer').then((value) {
      for (Map element in value) {
        int sId = element['senderId'];
        int rId = element['receiverId'];
        Transfer transfer = Transfer(
            senderName: users[sId].name,
            senderImage: users[sId].image,
            senderBalance: users[sId].balance,
            receiverName: users[rId].name,
            receiverImage: users[rId].image,
            receiverBalance: users[rId].balance,
            amount: element['amount']);
        transfers.add(transfer);
      }
      emit(AppGetTransferDatabaseState());
    });
  }

  Future<void> insertTransfersToDB() async {
    await database.transaction((txn) {
      var id1 = txn
          .rawInsert(
              'INSERT INTO transfer(senderId,receiverId,amount) VALUES($senderID,$receiverID,$transferAmount)')
          .then((value) => print(value));
      return id1;
    }).then((value) {
      print('transfer added');
      emit(AppInsertDatabaseState());
      getTransfersFromDatabase();
    });
  }

  Future<void> updateUsers() async {
    double newSenderBalance = users[senderID].balance - transferAmount;
    double newReceiverBalance = users[receiverID].balance + transferAmount;
    // Update some record
    print(
        '$senderID $receiverID ${users[senderID].balance}   ${users[receiverID].balance}');
    await database.rawUpdate('UPDATE user SET balance = ? WHERE id = ?',
        [newSenderBalance, senderID + 1]);
    await database.rawUpdate('UPDATE user SET balance = ? WHERE id = ?',
        [newReceiverBalance, receiverID + 1]).then((value) async {
      emit(AppUpdateDatabaseState());
    });
  }
}
