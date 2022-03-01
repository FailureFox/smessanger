import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class UserRepositoryUse extends UserRepository {
  final FirebaseFirestore firestore;
  UserRepositoryUse({required this.firestore});

  @override
  Future<String> setUser(UserModel profile) async {
    try {
      await firestore.collection('users').doc(profile.uid).set(profile.toMap());
      return profile.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> searchUser(
      {required String text, required UsersSearchType searchType}) async {
    final snapshot = await firestore
        .collection('users')
        .orderBy(searchType.name)
        .startAt([text]).endAt([text + '\uf8ff']).get();
    return snapshot.docs.map((e) => UserModel.fromMap(e.data(), e.id)).toList();
  }

  @override
  Stream<UserModel> getUser(String uid) {
    final snapshot = firestore.collection('users').doc(uid).snapshots();
    return snapshot.map((event) => UserModel.fromMap(event.data()!, uid));
  }
}

enum UsersSearchType { phoneNumber, name }

