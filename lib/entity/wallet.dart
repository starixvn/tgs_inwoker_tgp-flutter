class Wallet {
  double? balance;
  String? gpCode;
  String? title;
  bool isMainWallet;

  Wallet(this.gpCode, this.title, {this.isMainWallet = false});
}
