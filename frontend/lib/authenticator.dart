class Authenticator {
  static bool isLoggedIn = false;

  // User data
  static String? userName;
  static String? email;
  static String? profileImageUrl; // optional (can be null)

  static void login({
    required String name,
    required String email,
    String? imageUrl,
  }) {
    isLoggedIn = true;
    userName = name;
    Authenticator.email = email;
    profileImageUrl = imageUrl;
  }

  static void logout() {
    isLoggedIn = false;
    userName = null;
    email = null;
    profileImageUrl = null;
  }
}
