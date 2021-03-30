enum EventType {
  REGISTER,
  BIND,
  CHANGE,
  RESET_PASSWORD,
  CHECK,
  RESET_QUESTION,
  RESET_WITHDRAWAL_PASSWORD,
  REBIND
}


extension EventTypeExtension on EventType {

  static const name = {
    EventType.REGISTER: "register",
    EventType.BIND: "bind",
    EventType.CHANGE: "change",
    EventType.RESET_PASSWORD: "resetPassword",
    EventType.CHECK: "check",
    EventType.RESET_QUESTION: "resetQuestion",
    EventType.RESET_WITHDRAWAL_PASSWORD: "resetWithdrawalPassword",
    EventType.REBIND: "rebind",
  };

  String get displayName => name[this];
}

