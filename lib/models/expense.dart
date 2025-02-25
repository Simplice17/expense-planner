class Expense {
  String? id; // Firestore document ID should be a String
  String title;
  double amount;
  String category;
  DateTime date;

  Expense({
    this.id, // Make sure the ID is nullable and of type String
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Convert Expense object to Firestore document (without id)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(), // Ensure date is stored as ISO string
    };
  }

  // Convert Firestore document to Expense object
  factory Expense.fromMap(Map<String, dynamic> map, String documentId) {
    try {
      return Expense(
        id: documentId, // Assign Firestore document ID
        title: map['title'] ?? '', // Default empty string for title
        amount: (map['amount'] ?? 0).toDouble(), // Default to 0 if amount is missing or invalid
        category: map['category'] ?? '', // Default empty string for category
        date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()), // Default to now if date is invalid
      );
    } catch (e) {
      print("Error parsing Expense from Firestore: $e");
      rethrow; // Re-throw the exception if parsing fails
    }
  }
}
