/// Model class representing balance information
class Balance {
  /// Available balance amount
  final String? available;

  /// Outstanding balance amount (typically for credit cards)
  final String? outstanding;

  /// Creates a Balance instance
  const Balance({this.available, this.outstanding});

  /// Creates a Balance from JSON
  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      available: json['available'],
      outstanding: json['outstanding'],
    );
  }

  /// Converts Balance to JSON
  Map<String, dynamic> toJson() {
    return {'available': available, 'outstanding': outstanding};
  }

  @override
  String toString() {
    return 'Balance(available: $available, outstanding: $outstanding)';
  }
}
