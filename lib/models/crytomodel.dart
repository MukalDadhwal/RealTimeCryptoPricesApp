import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class CryptoModel {
  final List<Data> data;
  CryptoModel({
    required this.data,
  });

  CryptoModel copyWith({
    List<Data>? data,
  }) {
    return CryptoModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    List<Data> list = [];
    // ignore: avoid_function_literals_in_foreach_calls
    (map['data'] as List<dynamic>).forEach((element) {
      list.add(
        Data.fromMap(element as Map<String, dynamic>),
      );
    });
    print(list);
    return CryptoModel(data: list);
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CryptoModel(data: $data)';

  @override
  bool operator ==(covariant CryptoModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}

class Data {
  final int id;
  final String name;
  final String symbol;
  final String date_added;
  final List<String> tags;
  final int circulating_supply;
  final int cmc_rank;
  final String last_updated;
  final Quote quote;
  Color? color;
  String? imagePath;
  Data({
    required this.id,
    required this.name,
    required this.symbol,
    required this.date_added,
    required this.tags,
    required this.circulating_supply,
    required this.cmc_rank,
    required this.last_updated,
    required this.quote,
    this.color,
    this.imagePath,
  });

  set setColor(col) {
    color = col;
  }

  set setImagePath(localPath) {
    imagePath = localPath;
  }

  Data copyWith({
    int? id,
    String? name,
    String? symbol,
    String? date_added,
    List<String>? tags,
    int? circulating_supply,
    int? cmc_rank,
    String? last_updated,
    Quote? quote,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      date_added: date_added ?? this.date_added,
      tags: tags ?? this.tags,
      circulating_supply: circulating_supply ?? this.circulating_supply,
      cmc_rank: cmc_rank ?? this.cmc_rank,
      last_updated: last_updated ?? this.last_updated,
      quote: quote ?? this.quote,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
      'date_added': date_added,
      'tags': tags,
      'circulating_supply': circulating_supply,
      'cmc_rank': cmc_rank,
      'last_updated': last_updated,
      'quote': quote.toMap(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      date_added: map['date_added'] as String,
      tags: List<String>.from(
        (map['tags']),
      ),
      circulating_supply: map['circulating_supply'].toInt() as int,
      cmc_rank: map['cmc_rank'].toInt() as int,
      last_updated: map['last_updated'] as String,
      quote: Quote.fromMap(map['quote'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  // factory Data.fromJson(String source) =>
  //     Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(id: $id, name: $name, symbol: $symbol, date_added: $date_added, tags: $tags, circulating_supply: $circulating_supply, cmc_rank: $cmc_rank, last_updated: $last_updated, quote: $quote)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.symbol == symbol &&
        other.date_added == date_added &&
        listEquals(other.tags, tags) &&
        other.circulating_supply == circulating_supply &&
        other.cmc_rank == cmc_rank &&
        other.last_updated == last_updated &&
        other.quote == quote;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        date_added.hashCode ^
        tags.hashCode ^
        circulating_supply.hashCode ^
        cmc_rank.hashCode ^
        last_updated.hashCode ^
        quote.hashCode;
  }
}

class Quote {
  final USD usd;
  Quote({
    required this.usd,
  });

  Quote copyWith({
    USD? usd,
  }) {
    return Quote(
      usd: usd ?? this.usd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'USD': usd.toMap(),
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      usd: USD.fromMap(map['USD'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) =>
      Quote.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Quote(USD: $usd)';

  @override
  bool operator ==(covariant Quote other) {
    if (identical(this, other)) return true;

    return other.usd == usd;
  }

  @override
  int get hashCode => usd.hashCode;
}

class USD {
  final double price;
  final double percent_change_1h;
  final double percent_change_24h;
  final double percent_change_90d;
  final double market_cap;
  final double market_cap_dominance;
  USD({
    required this.price,
    required this.percent_change_1h,
    required this.percent_change_24h,
    required this.percent_change_90d,
    required this.market_cap,
    required this.market_cap_dominance,
  });

  USD copyWith({
    double? price,
    double? percent_change_1h,
    double? percent_change_24h,
    double? percent_change_90d,
    double? market_cap,
    double? market_cap_dominance,
  }) {
    return USD(
      price: price ?? this.price,
      percent_change_1h: percent_change_1h ?? this.percent_change_1h,
      percent_change_24h: percent_change_24h ?? this.percent_change_24h,
      percent_change_90d: percent_change_90d ?? this.percent_change_90d,
      market_cap: market_cap ?? this.market_cap,
      market_cap_dominance: market_cap_dominance ?? this.market_cap_dominance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'percent_change_1h': percent_change_1h,
      'percent_change_24h': percent_change_24h,
      'percent_change_90d': percent_change_90d,
      'market_cap': market_cap,
      'market_cap_dominance': market_cap_dominance,
    };
  }

  factory USD.fromMap(Map<String, dynamic> map) {
    return USD(
      price: map['price'].toDouble() as double,
      percent_change_1h: map['percent_change_1h'].toDouble() as double,
      percent_change_24h: map['percent_change_24h'].toDouble() as double,
      percent_change_90d: map['percent_change_90d'].toDouble() as double,
      market_cap: map['market_cap'].toDouble() as double,
      market_cap_dominance: map['market_cap_dominance'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory USD.fromJson(String source) =>
      USD.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'USD(price: $price, percent_change_1h: $percent_change_1h, percent_change_24h: $percent_change_24h, percent_change_90d: $percent_change_90d, market_cap: $market_cap, market_cap_dominance: $market_cap_dominance)';
  }

  @override
  bool operator ==(covariant USD other) {
    if (identical(this, other)) return true;

    return other.price == price &&
        other.percent_change_1h == percent_change_1h &&
        other.percent_change_24h == percent_change_24h &&
        other.percent_change_90d == percent_change_90d &&
        other.market_cap == market_cap &&
        other.market_cap_dominance == market_cap_dominance;
  }

  @override
  int get hashCode {
    return price.hashCode ^
        percent_change_1h.hashCode ^
        percent_change_24h.hashCode ^
        percent_change_90d.hashCode ^
        market_cap.hashCode ^
        market_cap_dominance.hashCode;
  }
}
