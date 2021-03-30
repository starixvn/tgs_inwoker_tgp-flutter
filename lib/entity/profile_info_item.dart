enum ProfileInfoItem {
  REAL_NAME,
  PHONE_NUMBER,
  EMAIL,
  QQ_NUMBER,
  WEIXIN_NUMBER,
  ADDRESS,
  LOGIN_PASSWORD,
  WITHDRAW_PASSWORD,
  SECURITY_ANSWER
}

extension ProfileInfoItemExtension on ProfileInfoItem {

  static const name = {
    ProfileInfoItem.REAL_NAME: "真实姓名",
    ProfileInfoItem.PHONE_NUMBER: "手机号码",
    ProfileInfoItem.EMAIL: "邮箱地址",
    ProfileInfoItem.QQ_NUMBER: "QQ号码",
    ProfileInfoItem.WEIXIN_NUMBER: "微信号码",
    ProfileInfoItem.ADDRESS: "收货地址",
    ProfileInfoItem.LOGIN_PASSWORD: "登陆密码",
    ProfileInfoItem.WITHDRAW_PASSWORD: "提款密码",
    ProfileInfoItem.SECURITY_ANSWER: "安全问题",
  };

  static const imagePath = {
    ProfileInfoItem.REAL_NAME: "images/profile_info/ic_profile_info_name.png",
    ProfileInfoItem.PHONE_NUMBER: "images/profile_info/ic_profile_info_phone.png",
    ProfileInfoItem.EMAIL: "images/profile_info/ic_profile_info_email.png",
    ProfileInfoItem.QQ_NUMBER: "images/profile_info/ic_profile_info_qq.png",
    ProfileInfoItem.WEIXIN_NUMBER: "images/profile_info/ic_profile_info_weixin.png",
    ProfileInfoItem.ADDRESS: "images/profile_info/ic_profile_info_address.png",
    ProfileInfoItem.LOGIN_PASSWORD: "images/profile_info/ic_profile_info_lock.png",
    ProfileInfoItem.WITHDRAW_PASSWORD: "images/profile_info/ic_profile_info_withdraw_password.png",
    ProfileInfoItem.SECURITY_ANSWER: "images/profile_info/ic_profile_info_security_answer.png",
  };

  String get displayName => name[this];
  String get getImagePath => imagePath[this];
}