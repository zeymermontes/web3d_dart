@JS("window")
library klaytn;

import 'dart:convert';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import '../../ethereum.dart';
import '../../ethers.dart';
import '../interop_wrapper.dart';
import 'exception.dart';

part 'contract.dart';
part 'interop.dart';
part 'transaction.dart';

/// Getter for default Klaytn object, cycles through available injector in environment.
Klaytn? get klaytn => Klaytn.provider;

class Klaytn extends Interop<_KlaytnImpl> {
  const Klaytn._(_KlaytnImpl impl) : super.internal(impl);

  static Klaytn? get provider => isSupported ? Klaytn._(_klaytn!) : null;

  static bool get isSupported => hasProperty(_window, 'klaytn');

  bool isConnected() => impl.isConnected();

  String? get selectedAddress => impl.selectedAddress;

  Future<List<String>> enable() async =>
      (await promiseToFuture<List<dynamic>>(impl.enable()))
          .map((e) => e.toString())
          .toList();

  Future<List<String>> getAccounts() async =>
      (await send('klay_accounts')).map((e) => e.toString()).toList();

  Future<dynamic> send(String method, [dynamic params]) async {
    return (await promiseToFuture<_RpcResponse>(impl.send(method, params)))
        .result;
  }

  Future<int> getChainId() async => int.parse(await send('klay_chainId'));

  onChainChanged(void Function(int chainId) callback) =>
      impl.on('networkChanged', allowInterop(callback));

  onAccountsChanged(void Function(List<String> accounts) callback) => impl.on(
      'accountsChanged',
      allowInterop((List<dynamic> accs) =>
          callback(accs.map((e) => e.toString()).toList())));
}
