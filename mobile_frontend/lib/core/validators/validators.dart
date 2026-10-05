import 'package:email_validator/email_validator.dart';

typedef Validator = String? Function(String?);

class Validators {
  static Validator required(String msg) =>
      (v) => (v == null || v.trim().isEmpty) ? msg : null;

  static Validator maxLength(int max, String msg) =>
      (v) => (v != null && v.length > max) ? msg : null;

  static Validator email(String msg) =>
      (v) => EmailValidator.validate(v?.trim() ?? '') ? null : msg;

  /// Runs validators in order, returns the first error.
  static Validator compose(List<Validator> validators) => (v) {
        for (final validate in validators) {
          final error = validate(v);
          if (error != null) return error;
        }
        return null;
      };
}