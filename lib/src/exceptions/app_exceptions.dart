enum AuthException {
  wrongEmailPassword(
    "The email or password you entered doesn't match our records. Please try again.",
  ),
  unknownServerError(
    'Internal server error occurred. Please try again later.',
  ),
  unknown(
    'Unknown error occurred. Please try again later.',
  ),
  ;

  final String message;
  const AuthException(this.message);
}

enum ExceptionPosts {
  unknownServerError(
    'Internal server error occurred. Please try again later.',
  ),
  unknown(
    'Unknown error occurred. Please try again later.',
  ),
  ;

  final String message;
  const ExceptionPosts(this.message);
}

enum ExceptionProfile {
  unknownServerError(
    'Internal server error occurred. Please try again later.',
  ),
  unknown(
    'Unknown error occurred. Please try again later.',
  ),
  ;

  final String message;
  const ExceptionProfile(this.message);
}
