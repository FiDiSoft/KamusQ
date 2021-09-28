class Validators {
  static String? validateUsername({required String username}) {
    // ignore: unnecessary_null_comparison
    if (username == null) {
      return null;
    }

    if (username.isEmpty) {
      return 'Username cannot be empty!';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    // ignore: unnecessary_null_comparison
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email cannot be empty!';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter the email according to the format!';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    // ignore: unnecessary_null_comparison
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password cannot be empty!';
    } else if (password.length < 6) {
      return 'Enter a password of more than 6 letters';
    }

    return null;
  }

  static String? validateVocab({required String vocab}) {
    // ignore: unnecessary_null_comparison
    if (vocab == null) {
      return null;
    }
    if (vocab.isEmpty) {
      return 'Word cannot be empty!';
    }

    return null;
  }

  static String? validateMeaning({required String meaning}) {
    // ignore: unnecessary_null_comparison
    if (meaning == null) {
      return null;
    }
    if (meaning.isEmpty) {
      return 'Meaning cannot be empty!';
    }

    return null;
  }
}
