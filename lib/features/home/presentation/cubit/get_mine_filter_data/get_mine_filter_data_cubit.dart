import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/models/filter.dart';
import '../../../domain/usecase/filter_usecase.dart';

part 'get_mine_filter_data_state.dart';

class GetMineFilterDataCubit extends Cubit<GetMineFilterDataState> {
  GetMineFilterDataCubit(this.usecase) : super(GetMineFilterDataInitial());

  final FilterUsecase usecase;
  FilterParams filterParams = FilterParams();
  List<AnnounceData> filterData = [];
  int currentPage = 1;
  bool isMore = true;
  String? currentStatus;
  Future<void> fGetMineFilter({
    bool? ifIsMore,
    String? status,
    bool isFirst = false,
  }) async {
    currentStatus = status ?? currentStatus;
    if (isFirst) {
      isMore = true;
      currentPage = 1;
      filterData = [];
    }
    isMore = ifIsMore ?? (isMore);
    if (isMore) {
      if (currentPage == 1) {
        filterData = [];
        emit(GetMineFilterLoadingState());
        filterParams = FilterParams(
          page: currentPage,
          mine: "1",
          status: currentStatus,
        );
      } else {
        filterParams.page = currentPage;
        emit(GetMineFilterPaginationLoadingState());
      }

      final failOrString = await usecase(filterParams);
      failOrString.fold((fail) {
        if (fail is ServerFailure) {
          emit(GetMineFilterErrorState(message: fail.message));
        }
      }, (reaponse) async {
        if (reaponse.data.meta != null) {
          if (currentPage < reaponse.data.meta!.lastPage) {
            currentPage += 1;
          } else {
            isMore = false;
          }
        }

        filterData = currentPage == 1
            ? reaponse.data.data
            : filterData + reaponse.data.data;

        emit(GetMineFilterSuccessState(
          data: filterData,
        ));
      });
    }
  }
}
