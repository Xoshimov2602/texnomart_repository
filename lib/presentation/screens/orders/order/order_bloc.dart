import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/hive/hive_helper.dart';
import '../../../../data/models/cart/cart_model.dart';
import '../../../../data/models/product/product_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    on<GetFavourites>((event, emit) {
      emit(state.copyWith(status: OrderStatus.loading));
      emit(state.copyWith(status: OrderStatus.success, data: HiveHelper.getFavorites()));
    });
  }
}
