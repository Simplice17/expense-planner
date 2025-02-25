class Income {
  String? id;
  String title;
  double amount;
  DateTime date;

  Income({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Convert Income object to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'title': title,  // ✅ Do not store 'id' in Firestore (Firestore assigns it)
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  // Convert Firestore document data to an Income object
  factory Income.fromMap(Map<String, dynamic> map, String documentId) {
    return Income(
      id: documentId,  // ✅ Assign Firestore document ID
      title: map['title'] ?? "No Title",
      amount: (map['amount'] ?? 0).toDouble(),  // ✅ Ensure double type
      date: DateTime.tryParse(map['date'] ?? "") ?? DateTime.now(),  // ✅ Prevent errors
    );
  }
}
