class User {
  final String name;
  final String email;
  final double balance;
  final String image;
  final int id;

  User(
      {this.id = 1,
      this.name = 'Ahmed',
      this.email = 'ahmed@gmail.com',
      this.balance = 15.0,
      this.image = 'assets/avatar1.png'});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'balance': balance,
    };
  }
}
