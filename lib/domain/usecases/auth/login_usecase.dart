import '../../../core/error/failures.dart';
import '../../../core/utils/result.dart';
import '../../../core/utils/validators.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Result<User>> call(String email, String password) async {
    // Validate email
    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      return Error<User>(ValidationFailure(emailError));
    }

    // Validate password
    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) {
      return Error<User>(ValidationFailure(passwordError));
    }

    return await repository.login(email, password);
  }
}
