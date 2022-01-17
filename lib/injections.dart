import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/resources/domain/repositories/auth_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/file_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/messages_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/token_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';
import 'package:smessanger/src/resources/domain/usecases/auth_repository_use.dart';
import 'package:smessanger/src/resources/domain/usecases/file_repository_use.dart';
import 'package:smessanger/src/resources/domain/usecases/messages_repository_use.dart';
import 'package:smessanger/src/resources/domain/usecases/token_repository_use.dart';
import 'package:smessanger/src/resources/domain/usecases/user_repository_use.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory<AppBloc>(
      () => AppBloc(tokenRepository: sl.call(), preferences: sl.call()));
  sl.registerFactory<AuthBloc>(
      () => AuthBloc(repository: sl.call(), tokenRepository: sl.call()));
  sl.registerFactory<RegistrationBloc>(() => RegistrationBloc(
      userRep: sl.call(),
      tokenRepository: sl.call(),
      authRep: sl.call(),
      filePick: sl.call(),
      fileRepository: sl.call()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(repository: sl.call()));

  //repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryUse(firestore: sl.call()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryUse(firestore: sl.call(), firebaseAuth: sl.call()));
  sl.registerLazySingleton<FileRepository>(
      () => FileRepositoryUse(firebaseStorage: sl.call()));
  sl.registerLazySingleton<MessagesRepository>(
      () => MessagesRepositoryUse(firestore: sl.call()));
  sl.registerLazySingleton<TokenRepository>(
      () => TokenRepositoryUse(securestorage: sl.call()));
  //

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final FirebaseStorage fStorage = FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FilePicker filePicker = FilePicker.platform;
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton<FilePicker>(() => filePicker);
  sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
  sl.registerLazySingleton<FirebaseStorage>(() => fStorage);
  sl.registerLazySingleton<FirebaseAuth>(() => fAuth);
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
}
