class AuthStatus {
  const AuthStatus();
}

class AuthLoginStatus extends AuthStatus {
  final String uid;
  AuthLoginStatus({required this.uid});
}

class AuthRegistrationStatus extends AuthStatus {
  final String uid;
  AuthRegistrationStatus({required this.uid});
}

class AuthInitialStatus extends AuthStatus {
  const AuthInitialStatus();
}

class AuthLoadingStatus extends AuthStatus {}

class AuthLoadedStatus extends AuthStatus {}

class AuthErrorStatus extends AuthStatus {
  final String error;
  AuthErrorStatus({required this.error});
}
