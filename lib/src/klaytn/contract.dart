part of klaytn;

class SmartContract {
  final String address;
  final String abi;
  final String signer;

  SmartContract(this.address, this.abi, this.signer);

  Future<BigInt> estimateGas(String method,
      [List<dynamic> args = const []]) async {
    final iface = Interface(abi);
    final encode = iface.encodeFunctionData(method, args);
    return BigInt.from(await promiseToFuture(_estimateGas(RequestEstimateGas(
      from: signer,
      to: address,
      data: encode,
    ))));
  }

  Future<TransactionResponse> send(
      {required String method,
      List<dynamic> args = const [],
      required BigInt gas,
      BigInt? value}) async {
    final iface = Interface(abi);
    final encode = iface.encodeFunctionData(method, args);
    print(encode);
    try {
      return TransactionResponse._(
          await promiseToFuture<_TransactionResponseImpl>(_sendTransaction(
              RequestTransaction(
                  type: 'SMART_CONTRACT_EXECUTION',
                  from: signer,
                  to: address,
                  data: encode,
                  gas: gas.toString(),
                  value: value?.toString()))));
    } catch (error) {
      final errorString = error.toString();
      const message = "Error: evm: execution reverted";
      if (errorString.contains(message)) {
        throw KlaytnEvmExcutionReverted(
            message, jsonDecode(dartify(errorString.replaceAll(message, ""))));
      } else if (errorString.contains("User denied transaction signatur")) {
        throw KlaytnUserRejected();
      } else {
        rethrow;
      }
    }
  }
}
