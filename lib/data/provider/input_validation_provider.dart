class InputValidationProvider{
  validateUsernamePasswordLength(String username){
    return RegExp("^.{6,20}\$",
        caseSensitive: false,
        multiLine: false
    ).hasMatch(username);
  }

  validateUsernamePassword(String username){
    return RegExp(r'^[a-zA-Z0-9]+$',
        caseSensitive: true,
        multiLine: false
    ).hasMatch(username);
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