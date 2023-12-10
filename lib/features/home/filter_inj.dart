import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import '../map/presentation/cubit/pick_map/pick_map_cubit.dart';
import '../notifications/presentation/cubit/notifications_cubit.dart';
import 'data/datasource/filter_datasource.dart';
import 'data/repo_impl/repo_impl.dart';
import 'domain/repo/filter_repo.dart';
import 'domain/usecase/add_annonce.dart';
import 'domain/usecase/aquar_details.dart';
import 'domain/usecase/delete_adv.dart';
import 'domain/usecase/delete_image.dart';
import 'domain/usecase/filter_usecase.dart';
import 'domain/usecase/network_types.dart';
import 'domain/usecase/notifications.dart';
import 'domain/usecase/update_ad.dart';
import 'domain/usecase/user_ads_count.dart';
import 'presentation/cubit/add_annoncement/addannoncement_cubit.dart';
import 'presentation/cubit/aquar_details/cubit/aquar_details_cubit.dart';
import 'presentation/cubit/delete_adv/cubit/delete_adv_cubit.dart';
import 'presentation/cubit/delete_image/cubit/delete_image_cubit.dart';
import 'presentation/cubit/get_mine_filter_data/get_mine_filter_data_cubit.dart';
import 'presentation/cubit/get_user_ads_count/cubit/get_user_ads_count_cubit.dart';
import 'presentation/cubit/home_cubit.dart';
import 'presentation/cubit/network_types/get_network_types_cubit.dart';
import 'presentation/cubit/similar_ads/cubit/similar_ads_cubit.dart';
import 'presentation/cubit/update_annoncement/cubit/update_annoncement_cubit.dart';

Future<void> initFilterInjection(GetIt sl) async {
  //* provider
  sl.registerFactory(() => FilterCubit(sl()));
  sl.registerFactory(() => GetMineFilterDataCubit(sl()));
  sl.registerFactory(() => SimilarAdsCubit(sl()));
  sl.registerLazySingleton(() => AquarDetailsCubit(sl()));
  sl.registerLazySingleton(() => PickMapCubit());
  sl.registerFactory(() => GetNetWorkTypesCubit(sl()));
  sl.registerFactory(() => AddAnnouncementCubit(sl()));
  sl.registerFactory(() => UpdateAnnoncementCubit(sl()));
  sl.registerFactory(() => NotificationsCubit(sl()));
  sl.registerFactory(() => GetUserAdsCountCubit(sl()));
  sl.registerFactory(() => DeleteAdvCubit(sl()));
  sl.registerFactory(() => DeleteImageCubit(sl()));

//* Use cases
  sl.registerLazySingleton(() => FilterUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteImageUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAdvUseCase(repository: sl()));
  sl.registerLazySingleton(() => AquarDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => NotificationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddAnnoncementUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateAnnoncementUsecase(repository: sl()));
  sl.registerLazySingleton(() => NetWorkTypesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UserAdsCountsUseCase(repository: sl()));
  //* Repository
  sl.registerLazySingleton<FilterRepository>(
    () => FilterRepositoryImp(
        remote: sl(),
        authLocal: sl(),
        authRemote: sl(),
        firebaseMessaging: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<FilterRemoteDatasource>(
      () => FilterRemoteDatasourceImpl(helper: sl()));
}

List<BlocProvider> filterBlocs({required BuildContext context}) => [
      BlocProvider<FilterCubit>(
          create: (BuildContext context) => sl<FilterCubit>()),
      BlocProvider<GetMineFilterDataCubit>(
        create: (BuildContext context) => sl<GetMineFilterDataCubit>(),
      ),
      BlocProvider<PickMapCubit>(
        create: (BuildContext context) => sl<PickMapCubit>(),
      ),
      BlocProvider<GetUserAdsCountCubit>(
        create: (BuildContext context) => sl<GetUserAdsCountCubit>(),
      ),
      BlocProvider<DeleteAdvCubit>(
        create: (BuildContext context) => sl<DeleteAdvCubit>(),
      ),
      BlocProvider<GetNetWorkTypesCubit>(
        create: (BuildContext context) => sl<GetNetWorkTypesCubit>(),
      ),
      BlocProvider<AddAnnouncementCubit>(
        create: (BuildContext context) => sl<AddAnnouncementCubit>(),
      ),
      BlocProvider<UpdateAnnoncementCubit>(
        create: (BuildContext context) => sl<UpdateAnnoncementCubit>(),
      ),
      BlocProvider<NotificationsCubit>(
        create: (BuildContext context) => sl<NotificationsCubit>(),
      ),
      BlocProvider<SimilarAdsCubit>(
        create: (BuildContext context) => sl<SimilarAdsCubit>(),
      ),
      BlocProvider<AquarDetailsCubit>(
        create: (BuildContext context) => sl<AquarDetailsCubit>(),
      ),
    ];
