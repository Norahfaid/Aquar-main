import 'package:aquar/features/favourite/data/repository_impl/repository_impl.dart';
import 'package:aquar/features/favourite/domain/usecase/get_fav.dart';
import 'package:aquar/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:aquar/features/favourite/presentation/cubit/toggle_fav/cubit/toggle_fav_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import 'data/datasource/remote_datasource.dart';
import 'domain/repo/fav_repo.dart';
import 'domain/usecase/toggle_fav.dart';

Future<void> initFavInjection(GetIt sl) async {
  //* provider
  sl.registerFactory(() => FavouriteCubit(sl()));
  sl.registerFactory(() => ToggleFavCubit(sl()));

//* Use cases
  sl.registerLazySingleton(() => GetFavouritiesUsecase(repository: sl()));
  sl.registerLazySingleton(() => ToggleFavouritiesUsecase(repository: sl()));
  //* Repository
  sl.registerLazySingleton<FavRepository>(
    () => FavRepositoryImp(remote: sl(), authLocal: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<GetFavRemoteDatasource>(
      () => GetFavRemoteDatasourceImpl(helper: sl()));
}

List<BlocProvider> favBlocs({required BuildContext context}) => [
      BlocProvider<FavouriteCubit>(
        create: (BuildContext context) => sl<FavouriteCubit>(),
      ),
      BlocProvider<ToggleFavCubit>(
        create: (BuildContext context) => sl<ToggleFavCubit>(),
      ),
    ];
