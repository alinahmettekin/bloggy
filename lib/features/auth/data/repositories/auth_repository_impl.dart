import 'package:bloggy/core/constants/constants.dart';
import 'package:bloggy/core/error/exceptions.dart';
import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/core/network/connection_checker.dart';
import 'package:bloggy/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloggy/core/common/entities/user.dart';
import 'package:bloggy/features/auth/data/models/user_model.dart';
import 'package:bloggy/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    if (!await connectionChecker.isConnected) {
      final session = remoteDataSource.currentUserSession;
      if (session == null) {
        return left(Failure('User not logged in'));
      }

      return right(UserModel(id: session.user.id, name: '', email: ''));
    }
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not found'));
      } else {
        return right(user);
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String name, required String password}) async {
    return _getUser(
      () async => remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
