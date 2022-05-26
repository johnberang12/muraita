import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class AuthBase{
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<ConfirmationResult> signInWithPhone(String phoneNumber);
  Future<void> signOut();

}

class Auth extends AuthBase{
  final _auth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<ConfirmationResult> signInWithPhone(String phoneNumber) async {
    final userCredential = await  _auth.signInWithPhoneNumber(phoneNumber);
    return userCredential;
  }

  // @override
  // Future<void> verifyNumber()async {
  //   try{
  //     _auth.verifyPhoneNumber(
  //       phoneNumber: '$selectedCountry$_phoneNumber',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential).then((value) {
  //
  //           _isLoading = false;
  //
  //         });
  //       },
  //
  //       verificationFailed: (FirebaseAuthException exception){
  //         setState((){
  //           _numberIsValid = false;
  //           _isLoading = false;
  //         });
  //
  //         _errorMessage = exception.message!;
  //
  //       },
  //       codeSent: (String verificationID, int? resendToken){
  //         _verificationCode = verificationID;
  //         _isLoading = false;
  //         Navigator.push(context, MaterialPageRoute(
  //           builder: (context) => VerifyNumber(
  //               verificationCode: _verificationCode,
  //               verifyNumber: _verifyNumber
  //           ),
  //         ));
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID){},
  //       // timeout: const Duration(seconds: 120),
  //     );
  //   } catch(e){
  //     print(e);
  //     setState((){
  //       _numberIsValid = false;
  //       _errorMessage = e.toString();
  //     });
  //   } finally {
  //     setState((){
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Future<void> signOut()async{
    await _auth.signOut();
  }

}