import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import 'data/datasource/nafaz_remote_datasource.dart';
import 'data/repository_impl/nafaz_repository_impl.dart';
import 'domain/repo/nafaz_repo.dart';
import 'domain/usecase/nafaz_usecase.dart';
import 'presentation/cubit/register_nafaz/register_nafaz_cubit.dart';

Future<void> initNafazInjection(GetIt sl) async {
  //* provider
  sl.registerFactory(() => RegisterNafazCubit(sl()));

  //* Use cases
  sl.registerLazySingleton(() => NafazUseCase(repository: sl()));

  //* Repository
  sl.registerLazySingleton<NafazRepository>(() => NafazRepositoryImp(remote: sl(), authLocal: sl(),));

  //* Data sources
  sl.registerLazySingleton<NafazRemoteDatasource>(() => NafazRemoteDatasourceImpl(helper: sl()));
}

List<BlocProvider> nafazBlocs({required BuildContext context}) => [
  BlocProvider<RegisterNafazCubit>(
    create: (BuildContext context) => sl<RegisterNafazCubit>(),
  ),
];
