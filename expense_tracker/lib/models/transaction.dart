//Just a blueprint to define a transaction

class Transaction {
  final String id;
  final String title;
  final int amount;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
