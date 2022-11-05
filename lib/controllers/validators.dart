String? valName(String name) {
  return name.isEmpty ? "Name can't be empty" : null;
}

String? valEmail(String email) {
  bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return email.isEmpty
      ? "Email can't be empty"
      : emailValid
      ? null
      : "Invalid email";
}

String? valPass(String password) {
  return password.isEmpty
      ? "Password can't be empty"
      : password.length < 8
      ? 'Password must be at least 8 characters long'
      : null;
}

String? valConfirmPass(String password, String confirmPassword) {
  return confirmPassword.isEmpty
      ? "Password can't be empty"
      : confirmPassword.length < 8
      ? 'Password must be at least 8 characters long'
      : password == confirmPassword
      ? null
      : 'Passwords must match';
}
