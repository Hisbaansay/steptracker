import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_steps_tracker/common/error/exceptions/firebase_auth_exception_app.dart';

abstract class ApplicationException implements Exception {}

class GenericApplicationException extends ApplicationException {
  final String message;

  GenericApplicationException({required this.message});
}

void firebaseErrorDecoder(FirebaseException e) {
  debugPrint(e.toString());
  if (e is FirebaseAuthException) {
    decodeAuthException(e);
  } else {
    throw GenericApplicationException(message: 'Something went wrong!');
  }
}

void decodeAuthException(FirebaseAuthException e) {
  if (e.code == 'auth/operation-not-allowed') {
    throw FirebaseAuthExceptionApp.operationNotAllowed(
      message: 'Something went wrong, please contact the support!',
    );
  } else {
    throw GenericApplicationException(message: 'Something went wrong!');
  }
}
