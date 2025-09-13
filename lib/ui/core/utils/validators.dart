class Validators {
  // -------------------
  // Regex Patterns
  // -------------------
  static final RegExp _emailRegex =
  RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  // Accepts international format (E.164): +countryCode + number (8–15 digits total)
  static final RegExp _phoneRegex = RegExp(r'^\+[1-9]\d{7,14}$');

  // -------------------
  // Helpers
  // -------------------
  static bool _isEmpty(String? value) => value == null || value.trim().isEmpty;

  // -------------------
  // Email
  // -------------------
  static String? validateEmail(
      String? value, {
        String emptyMsg = "Enter your email",
        String invalidMsg = "Invalid email format",
      }) {
    if (_isEmpty(value)) return emptyMsg;
    if (!_emailRegex.hasMatch(value!.trim())) return invalidMsg;
    return null;
  }

  // -------------------
  // Password
  // -------------------
  static String? validatePassword(
      String? value, {
        String emptyMsg = "Enter your password",
        String lengthMsg = "Password must be at least 8 characters",
        String strengthMsg =
        "Password must include uppercase, lowercase, number, and special character",
      }) {
    if (_isEmpty(value)) return emptyMsg;
    if (value!.length < 8) return lengthMsg;
    if (!_passwordRegex.hasMatch(value)) return strengthMsg;
    return null;
  }

  // -------------------
  // Confirm Password
  // -------------------
  static String? validateConfirmPassword(
      String? value,
      String password, {
        String emptyMsg = "Confirm your password",
        String mismatchMsg = "Passwords do not match",
      }) {
    if (_isEmpty(value)) return emptyMsg;
    if (value!.trim() != password.trim()) return mismatchMsg;
    return null;
  }

  // -------------------
  // Phone Number
  // -------------------
  static String? validatePhone(
      String? value, {
        String emptyMsg = "Enter your phone number",
        String invalidMsg =
        "Enter a valid phone number with country code (e.g. +201012345678)",
      }) {
    if (_isEmpty(value)) return emptyMsg;
    if (!_phoneRegex.hasMatch(value!.trim())) return invalidMsg;
    return null;
  }
}
