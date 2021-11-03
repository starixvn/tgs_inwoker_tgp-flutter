class InputValidationProvider {
  validateUsernameLength(String username) {
    return RegExp("^.{6,32}\$", caseSensitive: false, multiLine: false).hasMatch(username);
  }

  validatePasswordLength(String password) {
    return RegExp("^.{6,20}\$", caseSensitive: false, multiLine: false).hasMatch(password);
  }

  validateUsernamePassword(String username) {
    return RegExp(r'^[a-zA-Z0-9]+$', caseSensitive: true, multiLine: false).hasMatch(username);
  }

  validateChinaPhoneNumber(String phone) {
    return RegExp("^(?:\\+?86)?1\\d{10}\$", caseSensitive: true, multiLine: false).hasMatch(phone);
  }

  validateMalaysiaPhoneNumber(String phone) {
    return RegExp("^(\\+?6?01)[02-46-9]-*[0-9]{7}\$|^(\\+?6?01)[1]-*[0-9]{8}\$", caseSensitive: true, multiLine: false)
        .hasMatch(phone);
  }

  validateThaiPhoneNumber(String phone) {
    return RegExp("^(\\+?66)(\\d{1,2}\-?\\d{3,4}\-?\\d{3,4})\$", caseSensitive: true, multiLine: false).hasMatch(phone);
  }

  validateHKPhoneNumber(String phone) {
    return RegExp("^[2-9][0-9]{7}\$", caseSensitive: true, multiLine: false).hasMatch(phone);
  }

  validateEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$", caseSensitive: true, multiLine: false).hasMatch(email);
  }

  validateWechat(String wechat) {
    return RegExp("^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}\$", caseSensitive: true, multiLine: false).hasMatch(wechat);
  }

  validateQQ(String qq) {
    return RegExp("[1-9]\\d{4,14}", caseSensitive: true, multiLine: false).hasMatch(qq);
  }

  validateAreaCodeAndPhone(String area, String phone){
      var _phone = area+phone;
      switch (area) {
        case "+852":
          return validateHKPhoneNumber(_phone);
          break;
        case "+86":
          return validateChinaPhoneNumber(_phone);
          break;
        case "+60":
          return validateMalaysiaPhoneNumber(_phone);
          break;
        case "+66":
          return validateThaiPhoneNumber(_phone);
          break;
        default:
          return true;
          break;
      }
    }

  validateIncremental100(String amount) {
    return RegExp("^[1-9][0-9]{0,999}00\$", caseSensitive: true, multiLine: false).hasMatch(amount);
  }
}