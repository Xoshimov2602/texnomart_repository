import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/hive/hive_helper.dart';
import '../../../../data/models/cart/cart_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketState()) {
    on<GetItems>((event, emit) {
      emit(state.copyWith(status: BasketStatus.loading));
      emit(state.copyWith(status: BasketStatus.success, data: HiveHelper.getCartItems()));
    });
  }
}
