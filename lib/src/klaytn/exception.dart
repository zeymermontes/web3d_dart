class KlaytnException implements Exception {
  final String message;
  final dynamic data;

  const KlaytnException(this.message, this.data);
}

class KlaytnUserRejected extends KlaytnException {
  const KlaytnUserRejected(
      [String message =
          'Error: Kaikas Tx Signature: User denied transaction signature.'])
      : super(message, null);
}

class KlaytnEvmExcutionReverted extends KlaytnException {
  const KlaytnEvmExcutionReverted(String message, dynamic data)
      : super(message, data);
}
