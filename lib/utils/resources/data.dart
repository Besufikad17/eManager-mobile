bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  return  RegExp(pattern).hasMatch(phoneNumber);
}

bool isValidFullName(String fullName) {
  String pattern = r'^[a-z A-Z,.\-]+$';
  return RegExp(pattern).hasMatch(fullName);
}

bool isValidPassword(String password) {
  if(password.length >= 6 && password.length < 15) {
    return true;
  }else {
    return false;
  }
}