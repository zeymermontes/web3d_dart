part of klaytn;

class TransactionRequest {
  final String type;
  final String from;
  final String to;
  final String data;
  final BigNumber gas;
  // final BigNumber? value;
  TransactionRequest({
    required this.type,
    required this.from,
    required this.to,
    required this.data,
    required this.gas,
    // this.value,
  });
}

class TransactionReceipt extends Interop<_TransactionReceiptImpl> {
  const TransactionReceipt._(_TransactionReceiptImpl impl)
      : super.internal(impl);

  String get blockHash => impl.blockHash;
  int get blockNumber => impl.blockNumber;
  bool get byzantium => impl.byzantium;
  int get confirmations => impl.confirmations;
  String? get contractAddress => impl.contractAddress;
  BigInt get cumulativeGasUsed => impl.cumulativeGasUsed.toBigInt;
  String get from => impl.from;
  BigInt get gasUsed => impl.gasUsed.toBigInt;
  bool get isCreatingContract => to == null;
  String get logsBloom => impl.logsBloom;
  String? get root => impl.root;
  bool get status => impl.status != null && impl.status == 1;
  String? get to => impl.to;
  String get transactionHash => impl.transactionHash;
  int get transactionIndex => impl.transactionIndex;
}

class TransactionResponse extends Interop<_TransactionResponseImpl> {
  const TransactionResponse._(_TransactionResponseImpl impl)
      : super.internal(impl);

  String get blockHash => impl.blockHash;
  int? get blockNumber => impl.blockNumber;
  String? get contractAddress => impl.contractAddress;
  String? get from => impl.from;
  BigNumber? get gas => impl.gas;
  BigNumber? get gasPrice => impl.gasPrice;
  BigNumber? get gasUsed => impl.gasUsed;
  String? get input => impl.input;
  bool? get status => impl.status;
  String? get to => impl.to;
  String get transactionHash => impl.transactionHash;
  int? get transactionIndex => impl.transactionIndex;
  String? get type => impl.type;
  int? get typeInt => impl.typeInt;
  BigNumber? get value => impl.value;

  Future<dynamic> wait([int? confirms]) async {
    return TransactionReceipt._(
      await promiseToFuture<dynamic>(callMethod(
        this.impl,
        'wait',
        confirms != null ? [confirms] : [],
      )),
    );
  }
}
