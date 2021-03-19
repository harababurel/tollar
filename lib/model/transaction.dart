class Transaction {
  final int id;
  final String description;
  final double amount;
  final String currency;

  const Transaction({this.id, this.description, this.amount, this.currency});

  // Convert a Transaction into a Map.
  // The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'currency': currency,
    };
  }

  @override
  String toString() => '$description (id=$id)';
}
