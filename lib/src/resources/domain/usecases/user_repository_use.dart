import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/models/user_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class UserRepositoryUse extends UserRepository {
  final FirebaseFirestore firestore;
  UserRepositoryUse({required this.firestore});

  @override
  Stream<MyProfile> getMyUser(uid) {
    return firestore.collection('users').doc(uid).snapshots().map((event) =>
        MyProfile.fromMap(event.data() as Map<String, dynamic>, uid));
  }

  @override
  Stream<UserModel> getChatUser(String uid) {
    final snapshot = firestore.collection('users').doc(uid).snapshots();
    return snapshot.map((event) => UserModel.fromMap(event.data()!, uid));
  }
}
