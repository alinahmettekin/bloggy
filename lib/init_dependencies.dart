import 'package:bloggy/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloggy/core/secrets/app_secrets.dart';
import 'package:bloggy/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloggy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloggy/features/auth/domain/repository/auth_repository.dart';
import 'package:bloggy/features/auth/domain/usecases/current_user.dart';
import 'package:bloggy/features/auth/domain/usecases/user_login.dart';
import 'package:bloggy/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloggy/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonUrl,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
