import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/core/usecase/use_case.dart';
import 'package:bloggy/core/common/entities/user.dart';
import 'package:bloggy/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
