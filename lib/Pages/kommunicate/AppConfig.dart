class AppConfig {
 // static const APP_ID = '46255a021a2175a0c66fc43472ed9767';51784695d4e9f04eb6fc1ea45791d10
  static const APP_ID = '217dfa415810307f9998dc1565d51a8de';
  static bool isValidEmail(String emailId) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailId);
  }
}
