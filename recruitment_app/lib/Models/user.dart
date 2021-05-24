import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:recruitment_app/Database/collections.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends ChangeNotifier {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String level;
  @HiveField(4)
  final String positition;
  final Map<String, dynamic> audit;
  User({
    this.id,
    this.name,
    this.email,
    this.level,
    this.positition,
    this.audit,
  });

  static User get userRef => Hive.box('user').getAt(0) as User;

  User _user;

  User get user {
    return _user;
  }

  Future<void> addAplicantUser(User user) async {
    try {
      await Firestore.instance
          .collection(Collections.user)
          .document(user.id)
          .setData(
        {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'level': 'A', //means Aplicant
          'audit': user.audit,
        },
      );
      final newUser = new User(
        id: user.id,
        name: user.name,
        email: user.email,
        level: user.level,
        audit: user.audit,
      );

      _user = newUser;

      notifyListeners();
    } on PlatformException catch (e) {
      throw e.message;
    }
  }

  Future addLocalUser(User extuser) async {
    final userBox = Hive.box('user');
    if (userBox.isNotEmpty)
      for (int index = 0; index < userBox.length; index++) {
        userBox.deleteAt(index);
      }
    userBox.add(extuser);
  }

  void fetchLocalUser() {
    final localUser = Hive.box('user');
    _user = localUser as User;
  }

  Future<FirebaseUser> getUserId() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Future<void> fetchUser() async {
    try {
      final userId = await FirebaseAuth.instance.currentUser();
      if (userId != null) {
        final userRef = await Firestore.instance
            .collection(Collections.user)
            .document(userId.uid)
            .get();
        if (userRef.exists) {
          final newUser = new User(
            id: userId.uid,
            name: userRef.data['name'],
            email: userRef.data['email'],
            level: userRef.data['level'],
            audit: userRef.data['audit'],
          );
          await addLocalUser(newUser);
          _user = newUser;
          notifyListeners();
        }
      }
    } on PlatformException catch (e) {
      throw e.message;
    }
  }
}
