class RegistrationState {
  final String name;
  final String surname;
  final String avatarUrl;
  final List<String> roles;
  final List<String> interestedNews;
  RegistrationState({
    this.name = '',
    this.surname = '',
    this.avatarUrl = '',
    this.roles = const [],
    this.interestedNews = const [],
  });
  RegistrationState copyWith(
      {String? name,
      String? surname,
      String? avatarUrl,
      List<String>? roles,
      List<String>? interestedNews}) {
    return RegistrationState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      roles: roles ?? this.roles,
      interestedNews: interestedNews ?? this.interestedNews,
    );
  }
}
