part of 'market_bloc.dart';

class MarketState {
  MarketStatus? status;
  MarketsResponse? markets;
  List<OpenedStoresData>? openedMarkets;

  MarketState({this.markets, this.status, this.openedMarkets});

  MarketState copyWith({
    MarketStatus? status,
    MarketsResponse? markets,
    // MarketsProfile? marketProfile,
    List<OpenedStoresData>? openedMarkets
  }) => MarketState(
    status: status ?? this.status,
    markets: markets ?? this.markets,
    openedMarkets: openedMarkets ?? this.openedMarkets
  );
}

enum MarketStatus { success, failure, loading }
