class Validators {
  /// Email
  static String? validateEmail(String? value, {String emptyMsg = "Enter your email", String invalidMsg = "Invalid email"}) {
    if (value == null || value.isEmpty) return emptyMsg;
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return invalidMsg;
    return null;
  }

  /// Password (at least 8 chars, upper, lower, number, special)
  static String? validatePassword(String? value,
      {String emptyMsg = "Enter your password", String lengthMsg = "Password must be at least 8 characters", String strengthMsg = "Password must include uppercase, lowercase, number, and special character"}) {
    if (value == null || value.isEmpty) return emptyMsg;
    if (value.length < 8) return lengthMsg;

    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!regex.hasMatch(value)) return strengthMsg;

    return null;
  }

  /// Confirm Password
  static String? validateConfirmPassword(String? value, String password,
      {String emptyMsg = "Confirm your password", String mismatchMsg = "Passwords do not match"}) {
    if (value == null || value.isEmpty) return emptyMsg;
    if (value != password) return mismatchMsg;
    return null;
  }

  /// Phone number (exactly 11 digits)
  static String? validatePhone(String? value,
      {String emptyMsg = "Enter your phone number",
        String invalidMsg = "Phone must be 11 digits and start with 01"}) {
    if (value == null || value.isEmpty) return emptyMsg;
    final regex = RegExp(r'^(01)[0-9]{9}$'); // must start with 01 + 9 digits
    if (!regex.hasMatch(value)) return invalidMsg;
    return null;
  }
}
