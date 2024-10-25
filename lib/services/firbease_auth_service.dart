import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  // Sign in with email and password method
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;      
    } on FirebaseAuthException catch (e) {
      print("Error signing in: ${e.message}");
      return null;
    }
  }

  // Updated signUpWithEmail to include name
  Future<User?> signUpWithEmail(String email, String password, String phone, String city, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      // Add additional fields (like phone, city, and name) to Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'phone': phone,
          'city': city,
          'name': name, 
           'password':password,
        });
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if a user is signed in
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
