typedef Validator = String? Function(String? value);

class ValidatorBuilder {
  /// Returns a validator that ensures the field is not empty.
  static Validator required({String message = 'This field is required'}) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    };
  }

  /// Ensures the value contains only alphabetic characters and spaces.
  /// Useful for name fields.
  static Validator isString({String message = 'Invalid characters'}) {
    final alpha = RegExp(r'^[a-zA-Z\s]+$');
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      return alpha.hasMatch(value.trim()) ? null : message;
    };
  }

  /// Minimum length validator.
  static Validator minLength(int min, {String? message}) {
    return (String? value) {
      if (value == null) return null;
      if (value.trim().length < min) {
        return message ?? 'Minimum $min characters required';
      }
      return null;
    };
  }

  /// Maximum length validator.
  static Validator maxLength(int max, {String? message}) {
    return (String? value) {
      if (value == null) return null;
      if (value.trim().length > max) {
        return message ?? 'Maximum $max characters allowed';
      }
      return null;
    };
  }

  /// Email format validator.
  static Validator email({String message = 'Enter a valid email'}) {
    final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$");
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      return emailRegex.hasMatch(value.trim()) ? null : message;
    };
  }

  /// Ensures the value consists only of digits and has exact [length].
  /// Example: use `ValidatorBuilder.numericLength(10)` for a 10-digit mobile number.
  static Validator numericLength(int length, {String? message}) {
    final regex = RegExp(r'^\d{' + length.toString() + r'}$');
    return (String? value) {
      if (value == null || value.trim().isEmpty) return null;
      return regex.hasMatch(value.trim())
          ? null
          : (message ?? 'Enter a valid $length-digit number');
    };
  }

  /// Compose multiple validators into one. Runs validators in order and
  /// returns the first non-null error message.
  static Validator compose(List<Validator> validators) {
    return (String? value) {
      for (final v in validators) {
        final res = v(value);
        if (res != null) {
          return res;
        }
      }
      return null;
    };
  }

  /// General-purpose validate helper that returns error string or null.
  static String? validate(String? value, List<Validator> validators) {
    return compose(validators)(value);
  }
}
