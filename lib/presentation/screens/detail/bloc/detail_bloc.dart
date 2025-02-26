import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../data/hive/hive_helper.dart';
import '../../../../data/models/product/product_model.dart';
import '../../../../data/repository/main/product_repository.dart';
import '../../../../data/source/remote/response/accessoiries/accessories_response.dart';
import '../../../../data/source/remote/response/detail_about/detail_about_response.dart';
import '../../../../data/source/remote/response/details/details_response.dart';
import '../../../../data/source/remote/response/info/info_response.dart';
import '../../../../data/source/remote/response/leader_sale/leader_sale_response.dart';
import '../../../../data/source/remote/response/markets/markets_response.dart';
import '../../../../di/di.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final repository = getIt<ProductRepository>();

  DetailBloc() : super(DetailState()) {
    on<GetDetail>((event, emit) async {
      emit(state.copyWith(status: DetailsStatus.loading));
      try {
        final result = await repository.getDetail(event.id);
        final second = await repository.getLeaderSales();
        final third = await repository.getInfo(event.id);
        final fourth = await repository.getDataAbout(event.id);
        var fifth = await repository.getAccessories(event.id);
        var sixth = await repository.getMarkets(event.id);
        if (fifth.data?.data == null && fifth.data?.data?.length == 0) fifth = [] as AccessoriesResponse;
        emit(
          state.copyWith(
            status: DetailsStatus.success,
            detail: result,
            leaders: second,
            info: third,
            accessories: fifth,
            about: fourth,
            markets: sixth
          ),
        );
      } on DioException {
        emit(state.copyWith(status: DetailsStatus.failure));
      }
    });
  }
}
