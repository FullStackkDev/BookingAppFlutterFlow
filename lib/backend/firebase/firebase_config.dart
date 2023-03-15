import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBkbF389DTUXWbVRBJCUMQPqdi5nDhfsgA",
            authDomain: "hotelbookingapp-95392.firebaseapp.com",
            projectId: "hotelbookingapp-95392",
            storageBucket: "hotelbookingapp-95392.appspot.com",
            messagingSenderId: "657773074977",
            appId: "1:657773074977:web:0b3065bf5ab7f4f5f72160",
            measurementId: "G-BTR4M8XDYP"));
  } else {
    await Firebase.initializeApp();
  }
}
