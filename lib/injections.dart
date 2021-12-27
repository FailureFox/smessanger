import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smessanger/src/resources/data/firebase_remote.dart';
import 'package:smessanger/src/resources/data/firebase_remote_use.dart';
import 'package:smessanger/src/resources/domain/repositories/firebase_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/firebase_repository_use.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //useCases

  sl.registerLazySingleton<FireBaseRemote>(
    () => FireBaseRemoteUse(
      firebaseAuth: sl.call(),
      firestore: sl.call(),
      firebaseStorage: sl.call(),
    ),
  );

  sl.registerLazySingleton<FireBaseRepository>(
      () => FireBaseRepositoryUse(firebase: sl.call()));

  //firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
  sl.registerLazySingleton<FirebaseStorage>(() => storage);
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
}
