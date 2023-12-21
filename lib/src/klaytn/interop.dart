part of klaytn;

@JS("window")
external Object get _window;

@JS("klaytn")
external _KlaytnImpl? get _klaytn;

@JS()
@anonymous
class _KlaytnImpl {
  external enable();
  external _RpcResponse send(String method, [dynamic params]);
  external on(String eventName, Function callback);
  external String? get selectedAddress;
  external bool isConnected();
}

@JS("RpcResponse")
@anonymous
class _RpcResponse {
  external int get id;
  external String get jsonrpc;
  external dynamic get result;
}

@JS("caver.klay.call")
external dynamic _call(dynamic o);

@JS("caver.klay.sendTransaction")
external dynamic _sendTransaction(dynamic o);

@JS("caver.klay.estimateGas")
external dynamic _estimateGas(RequestEstimateGas request);

@JS()
@anonymous
class RequestEstimateGas {
  external String? get from;
  external String get to;
  external String get data;
  external factory RequestEstimateGas({String to, String data, String? from});
}

@JS()
@anonymous
class RequestTransaction {
  external String get type;
  external String get from;
  external String get to;
  external String get data;
  external String get gas;
  external String? get value;
  external factory RequestTransaction(
      {String type,
      String from,
      String to,
      String data,
      String gas,
      String? value});
}

@JS()
@anonymous
class _TransactionResponseImpl {
  external String get blockHash;
  external int? get blockNumber;
  external String? get contractAddress;
  external String? get from;
  external BigNumber? get gas;
  external BigNumber? get gasPrice;
  external BigNumber? get gasUsed;
  external String? get input;
  external bool? get status;
  external String? get to;
  external String get transactionHash;
  external int? get transactionIndex;
  external String? get type;
  external int? get typeInt;
  external BigNumber? get value;
  // logs 제외
}

@JS()
@anonymous
class _TransactionReceiptImpl {
  external String get blockHash;
  external int get blockNumber;
  external bool get byzantium;
  external int get confirmations;
  external String? get contractAddress;
  external BigNumber get cumulativeGasUsed;
  external String get from;
  external BigNumber get gasUsed;
  external List<dynamic> get logs;
  external String get logsBloom;
  external String? get root;
  external int? get status;
  external String? get to;
  external String get transactionHash;
  external int get transactionIndex;
}
