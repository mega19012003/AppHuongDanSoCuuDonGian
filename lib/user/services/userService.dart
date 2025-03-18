import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Đăng ký bằng Email và Mật khẩu
  Future<User?> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
    required int age,
    required String phoneNumber,
    required String gender,
  }) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // Lưu thông tin người dùng vào Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
          'age': age,
          'phoneNumber': phoneNumber,
          'gender': gender,
          'role': 'user',
        });
      }

      return user;
    } catch (e) {
      print("Đăng ký thất bại: $e");
      return null;
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Không tìm thấy người dùng với email này.');
      } else if (e.code == 'wrong-password') {
        print('Sai mật khẩu.');
      } else {
        print('Lỗi khác: ${e.message}');
      }
    } catch (e) {
      print("Đăng nhập thất bại: $e");
    }
    return null;
  }

  // Đăng nhập bằng Google
  /*Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // Người dùng hủy đăng nhập
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Đăng nhập Google thất bại: $e");
      return null;
    }
  }*/

  // Đăng xuất
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

