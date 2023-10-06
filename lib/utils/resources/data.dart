bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  return  RegExp(pattern).hasMatch(phoneNumber);
}

bool isValidPassword(String password) {
  if(password.length >= 6 && password.length < 15) {
    return true;
  }else {
    return false;
  }
}