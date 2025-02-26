import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../data/repository/main/product_repository.dart';
import '../../../../data/source/remote/response/markets/markets_response.dart';
import '../../../../di/di.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final repository = getIt<ProductRepository> ();
  MarketBloc() : super(MarketState()) {
    on<GetMarkets>((event, emit) async {
      emit(state.copyWith(status: MarketStatus.loading));
      try {
        final result = await repository.getMarkets(event.id);
        // final second = await repository.getMarketsProfile();
        emit(state.copyWith(status:  MarketStatus.success, markets: result, /*marketProfile: second*/));
      } on DioException {
        print("OPOPOPOPPPOPOP  in bloc erroring in bloc");
        emit(state.copyWith(status: MarketStatus.failure));
      }
    });
  }
}
