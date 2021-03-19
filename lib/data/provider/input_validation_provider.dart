class InputValidationProvider{
  validateUsernameLength(String username){
    return RegExp("^.{8,16}\$",
        caseSensitive: false,
        multiLine: false
    ).hasMatch(username);
  }

  validatePasswordLength(String password){
    return RegExp("^.{6,20}",
        caseSensitive: false,
        multiLine: false
    ).hasMatch(password);
  }

  validatePassword(String password){
    return RegExp("^([a-zA-Z0-9!@#\$%^&*+=])*\$",
        caseSensitive: true,
        multiLine: false
    ).hasMatch(password);
  }

  validateChinaPhoneNumber(String phone){
    return RegExp("^(?:\\+?86)?1\\d{10}\$",
        caseSensitive: true,
        multiLine: false
    ).hasMatch(phone);
  }

  validateEmail(String email){
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
        caseSensitive: true,
        multiLine: false
    ).hasMatch(email);
  }
}