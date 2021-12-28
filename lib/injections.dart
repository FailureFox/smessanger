import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/resources/data/firebase_remote.dart';
import 'package:smessanger/src/resources/data/firebase_remote_use.dart';
import 'package:smessanger/src/resources/domain/repositories/firebase_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/firebase_repository_use.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //useCases
  sl.registerFactory<AuthBloc>(() => AuthBloc(firebase: sl.call()));
  sl.registerFactory<RegistrationBloc>(
      () => RegistrationBloc(filePick: sl.call(), fRepostiry: sl.call()));
  //firebase
  sl.registerLazySingleton<FireBaseRemote>(() => FireBaseRemoteUse(
      firebaseAuth: sl.call(),
      firestore: sl.call(),
      firebaseStorage: sl.call()));

  sl.registerLazySingleton<FireBaseRepository>(
      () => FireBaseRepositoryUse(firebase: sl.call()));
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FilePicker filePicker = FilePicker.platform;
  sl.registerLazySingleton<FilePicker>(() => filePicker);
  sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
  sl.registerLazySingleton<FirebaseStorage>(() => storage);
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
}
