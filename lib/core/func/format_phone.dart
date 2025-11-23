/// Formats an Egyptian phone number into a standardized display format.
///
/// Examples:
/// - Input: "01012345678"      -> Output: "+20 10 1234 5678"
/// - Input: "201112345678"     -> Output: "+20 11 1234 5678"
/// - Input: "+201212345678"    -> Output: "+20 12 1234 5678"
/// - Input: "015 123 456 78"   -> Output: "+20 15 1234 5678"
String formatEgyptianPhoneNumber(String phone) {
  if (phone.isEmpty) return '';

  // 1. Remove all non-numeric characters
  String cleaned = phone.replaceAll(RegExp(r'\D'), '');

  // 2. Handle Country Code cases
  // Case: Starts with '20' (e.g., 2010xxxx) -> remove '20'
  if (cleaned.startsWith('20')) {
    cleaned = cleaned.substring(2);
  }
  // Case: Starts with '0' (e.g., 010xxxx) -> remove '0'
  else if (cleaned.startsWith('0')) {
    cleaned = cleaned.substring(1);
  }

  // 3. Format if it matches Egyptian Mobile Structure
  // Remaining 'cleaned' should be 10 digits: Prefix (2) + Number (8)
  // Example: 10 1234 5678
  if (cleaned.length == 10 &&
      (cleaned.startsWith('10') ||
          cleaned.startsWith('11') ||
          cleaned.startsWith('12') ||
          cleaned.startsWith('15'))) {
    final prefix = cleaned.substring(0, 2); // 10, 11, 12, 15
    final part1 = cleaned.substring(2, 6); // Next 4 digits
    final part2 = cleaned.substring(6); // Last 4 digits

    return '+20 $prefix $part1 $part2';
  }

  // 4. Fallback: Return original if it doesn't match expected structure
  return phone;
}
