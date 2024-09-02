import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rasoi/localdb.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//SIGNING IN WITH GOOGLE

Future<User?> SignInWithGoogle() async
{
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

  //CREATING CREDENTIAL FOR FIREBASE

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
  );

  //SIGNING IN WITH CREDENTIAL AND GETTING USER CLASS

  final userCredential = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  //CHECKING IS ON

  assert(!user!.isAnonymous);
  assert(await user!.getIdToken() != null);


  final User? currentUser = await _auth.currentUser;
  assert(currentUser!.uid == user!.uid);
  print(user);
  LocalDataSaver.saveName(user!.displayName.toString());
  LocalDataSaver.saveMail(user.email.toString());
  LocalDataSaver.saveImg(user.photoURL.toString());

  return user;

}