import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoV9-Od3yO8bYis-PF2Mj-wMDNBK0YrJA',
    authDomain: 'ssuriset-flutter-demo.firebaseapp.com',
    projectId: 'ssuriset-flutter-demo',
    storageBucket: 'ssuriset-flutter-demo.firebasestorage.app',
    messagingSenderId: '323217692512',
    appId: '1:323217692512:web:8cc6544add02856c54f005',
  );
  static FirebaseOptions get currentPlatform => web;
}
