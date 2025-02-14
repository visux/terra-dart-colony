import 'dart:typed_data';

import 'package:terra_dart_sdk_protos/proto_out/third_party/cosmos/base/v1beta1/coin.pb.dart'
    as CF;
import '../src/rest/Json/CoinJSON.dart';
import 'Numeric.dart';

class Coin implements Numeric<Coin, dynamic> {
  final BigInt? amount;
  final String? denom;

  Coin(this.denom, this.amount);

  static Coin fromAmino(CoinAminoArgs data) {
    return Coin(data.denom, data.amount);
  }

  static Coin fromData(CoinDataArgs data) {
    return Coin(data.denom, data.amount);
  }

  static Coin fromJSON(CoinJSON data) {
    return Coin(data.denom, BigInt.parse(data.amount!));
  }

  static Coin fromProto(CF.Coin data) {
    return Coin(data.denom, BigInt.parse(data.amount));
  }

  CoinDataArgs toData() {
    return CoinDataArgs()
      ..denom = denom
      ..amount = amount;
  }

  Uint8List toProto() {
    return toProtoWithType().writeToBuffer();
  }

  CF.Coin toProtoWithType() {
    var coin = CF.Coin();
    coin.amount = amount.toString();
    coin.denom = denom.toString();

    return coin;
  }

  CoinAminoArgs toAmino() {
    return CoinAminoArgs()
      ..denom = denom
      ..amount = amount;
  }

  CoinJSON toJSON() {
    return CoinJSON(denom!, amount.toString());
  }

  Coin toLongCoin() {
    return Coin(denom, amount);
  }

  Coin toLongCeilCoin() {
    return Coin(denom, (amount));
  }

  Coin toDecCoin() {
    return Coin(denom, amount);
  }

  @override
  String toString() {
    return "$amount$denom";
  }

  static Coin fromString(String str) {
    final String coinRegex = r"/^(-?[0-9]+(\\.[0-9]+)?)([0-9a-zA-Z/]+)$/";
    bool m = RegExp(coinRegex).hasMatch(str);
    if (!m) {
      throw Exception("failed to parse to Coin: $str");
    }

    var amount = BigInt.parse(str[1]);
    var denom = str[3];

    return Coin(denom, amount);
  }

  @override
  Coin add(value) {
    return Coin(denom, amount! + BigInt.parse(value));
  }

  @override
  Coin div(value) {
    return Coin(denom, (amount! / BigInt.parse(value)) as BigInt?);
  }

  @override
  Coin mod(value) {
    return Coin(denom, BigInt.parse(value).abs());
  }

  @override
  Coin mul(value) {
    return Coin(denom, amount! * BigInt.parse(value));
  }

  @override
  Coin sub(value) {
    return Coin(denom, amount! - BigInt.parse(value));
  }
}

class CoinAminoArgs {
  String? denom;
  BigInt? amount;
}

class CoinDataArgs {
  String? denom;
  BigInt? amount;
}
