import 'dart:developer';

import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/core/usecase/use_case.dart';
import 'package:bloggy/core/common/entities/user.dart';
import 'package:bloggy/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    log('user sign up class çalıştı');
    return await authRepository.signUpWithEmailPassword(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
