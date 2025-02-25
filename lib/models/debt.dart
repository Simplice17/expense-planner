class Debt {
  String? id; // ✅ Change `id` from int? to String?
  String person;
  double amount;
  String description;
  DateTime date;

  Debt({
    this.id,  // Firestore document ID
    required this.person,
    required this.amount,
    required this.description,
    required this.date,
  });

  // Convert Debt object to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'person': person, // ✅ Do not store 'id' in Firestore (Firestore assigns it)
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Convert Firestore document data to a Debt object
  factory Debt.fromMap(Map<String, dynamic> map, String documentId) {
    return Debt(
      id: documentId, // ✅ Assign Firestore document ID
      person: map['person'] ?? "Unknown",
      amount: (map['amount'] ?? 0).toDouble(), // ✅ Ensure `double` type
      description: map['description'] ?? "No Description",
      date: DateTime.tryParse(map['date'] ?? "") ?? DateTime.now(), // ✅ Prevent errors
    );
  }
}
