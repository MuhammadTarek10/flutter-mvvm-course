class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class ResetPasswordRequest {
  String email;

  ResetPasswordRequest(this.email);
}
