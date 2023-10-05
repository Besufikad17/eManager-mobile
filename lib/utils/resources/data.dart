bool isVlaidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool isValidPassword(String password) {
  if(password.length >= 6 && password.length < 15) {
    return true;
  }else {
    return false;
  }
}