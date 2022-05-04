class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class ResetPasswordRequest {
  String email;

  ResetPasswordRequest(this.email);
}

class RegisterRequest {
  String username;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterRequest(
    this.username,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
