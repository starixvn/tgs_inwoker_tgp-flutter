class InputValidationProvider{
  validateUsernameLength(String username){
    return RegExp("^.{6,32}\$",
        caseSensitive: false,
        multiLine: false
    ).hasMatch(username);
  }

  validatePasswordLength(String password){
    return RegExp("^.{6,20}\$",
        caseSensitive: false,
        multiLine: false
    ).hasMatch(password);
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

  validateWechat(String wechat){
    return RegExp("^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}\$",
        caseSensitive: true,
        multiLine: false
    ).hasMatch(wechat);
  }

  validateQQ(String qq){
    return RegExp("[1-9]\\d{4,14}",
        caseSensitive: true,
        multiLine: false
    ).hasMatch(qq);
  }
}