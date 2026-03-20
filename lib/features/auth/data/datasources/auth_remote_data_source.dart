abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> signInWithEmail(String email);
  Future<bool> verifyEmail(String email, String code);
  Future<Map<String, dynamic>> createProfile(
    String email,
    String fullName,
    String username,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Mock implementations to test flow

  @override
  Future<Map<String, dynamic>> signInWithEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay
    return {'id': '123', 'email': email};
  }

  @override
  Future<bool> verifyEmail(String email, String code) async {
    await Future.delayed(const Duration(seconds: 1));
    return code == '123456' || code.isNotEmpty; // Accept any code for now
  }

  @override
  Future<Map<String, dynamic>> createProfile(
    String email,
    String fullName,
    String username,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'id': '123',
      'email': email,
      'fullName': fullName,
      'username': username,
    };
  }
}
