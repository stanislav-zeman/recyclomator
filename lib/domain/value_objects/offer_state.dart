enum OfferState {
  free,
  reserved,
  unconfirmed,
  done,
  canceled,
}

extension OfferStateExtension on OfferState {
  bool get isFinished => this == OfferState.canceled || this == OfferState.done;
}
