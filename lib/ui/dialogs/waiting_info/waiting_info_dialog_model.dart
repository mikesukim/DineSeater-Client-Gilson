import 'package:stacked/stacked.dart';

class WaitingInfoDialogModel extends BaseViewModel {

  String formatPhoneNumber(String phoneNumber) {
    // Remove all non-numeric characters except '+'
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d\+]+'), '');

    // Check if the cleaned number starts with a '+' and has a length of at least 12 digits (including '+')
    if (cleaned.startsWith('+') && cleaned.length >= 12) {
      // Extract the country code and the remaining digits
      String countryCode = cleaned.substring(0, 2); // Assumes the country code is two digits
      String remainingDigits = cleaned.substring(2);

      // Split the remaining digits into groups of 3, 3, and 4
      String formattedNumber = remainingDigits.replaceFirstMapped(
          RegExp(r'(\d{3})(\d{3})(\d{4})'),
              (match) => '(${match[1]}) ${match[2]} ${match[3]}');

      // Combine the formatted number with the country code and '+'
      return '$countryCode $formattedNumber';
    }

    // Return the original number if it doesn't match the expected format
    return phoneNumber;
  }

}
