class AccountTransaction {
  String date, title, category;
  double amount;
  bool isReceived;

  AccountTransaction(
      {required this.date,
      required this.title,
      required this.category,
      required this.amount,
      this.isReceived = false});
}
