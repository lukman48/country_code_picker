/// Country model with phone formatting and display data
class Country {
  final String code;           // ISO 3166-1 alpha-2 code (e.g., 'US')
  final String name;           // Full country name (e.g., 'United States')
  final String flag;           // Flag emoji
  final String dialCode;       // Phone dial code (e.g., '+1')
  final String? phoneFormat;   // Optional phone number format pattern
  final String region;         // Region for grouping (e.g., 'Americas')

  Country({
    required this.code,
    required this.name,
    required this.flag,
    required this.dialCode,
    this.phoneFormat,
    this.region = 'Other',
  });

  /// Display format: 🇺🇸 United States +1
  String get displayName => '$flag $name $dialCode';

  /// Search-friendly format
  String get searchableText => '$name $code $dialCode'.toLowerCase();

  /// Get formatted phone number (if format available)
  String formatPhoneNumber(String number) {
    if (phoneFormat == null) return dialCode + number;
    // Simple formatter - replace X with digits
    String formatted = phoneFormat!;
    int digitIndex = 0;
    final result = StringBuffer();
    
    for (int i = 0; i < formatted.length && digitIndex < number.length; i++) {
      if (formatted[i] == 'X') {
        result.write(number[digitIndex]);
        digitIndex++;
      } else {
        result.write(formatted[i]);
      }
    }
    
    return result.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

/// Country picker selection result
class CountrySelection {
  final Country country;
  final DateTime selectedAt;

  CountrySelection({
    required this.country,
    DateTime? selectedAt,
  }) : selectedAt = selectedAt ?? DateTime.now();
}
