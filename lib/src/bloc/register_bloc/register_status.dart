abstract class RegistrationStatus {
  const RegistrationStatus();
}

class RegistrationInitialStatus extends RegistrationStatus {
  const RegistrationInitialStatus();
}

class RegAvatarLoadingStatus extends RegistrationStatus {}

class RegAvatarLoadedStatus extends RegistrationStatus {}

class RegAvatarErrorStatus extends RegistrationStatus {}
