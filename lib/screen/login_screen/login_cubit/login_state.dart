abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  const LoginLoaded();
}

class LoginError extends LoginState {
  final String alert;

  const LoginError(this.alert);
}

class LoginAuthenticate extends LoginState {
  const LoginAuthenticate();
}
