import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HotelBookingAppFirebaseUser {
  HotelBookingAppFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

HotelBookingAppFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HotelBookingAppFirebaseUser> hotelBookingAppFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<HotelBookingAppFirebaseUser>(
      (user) {
        currentUser = HotelBookingAppFirebaseUser(user);
        return currentUser!;
      },
    );
