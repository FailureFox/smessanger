abstract class AppEvents {}

class AppThemeLoadingEvent extends AppEvents {}

class AppThemeChangeEvent extends AppEvents {}

class AppTokenLoadingEvent extends AppEvents {
  final String uid;
  AppTokenLoadingEvent({required this.uid});
}
