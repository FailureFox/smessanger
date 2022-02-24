import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class SearchPerson {
  final FirebaseFirestore firestore;
  SearchPerson({required this.firestore});

  Future<List<UserModel>> searchPersonFromNumber(
      {required String phoneNumber}) async {
    final persons = await firestore
        .collection('users')
        .orderBy('phoneNumber')
        .startAt([phoneNumber]).endAt(['phoneNumber' + '\uf8ff']).get();
    return persons.docs.map((e) => UserModel.fromMap(e.data(), e.id)).toList();
  }
}
