import 'package:flutter/foundation.dart';

class UIModel<T> {
  final UIState state;
  final T? data;
  final Object? error;

  UIModel(this.state, this.data, this.error);

  factory UIModel.ok(T data) {
    return UIModel(UIState.ok, data, null);
  }

  factory UIModel.loading(T? data) {
    return UIModel(UIState.loading, data, null);
  }

  factory UIModel.error(Object? error, {Object? data}) {
    return UIModel(UIState.error, data as T?, error);
  }

  bool compareData(UIModel other) {
    if (data is List) {
      return listEquals(data as List, other.data);
    } else {
      return data == other.data;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UIModel && compareData(other) && error == other.error;

  @override
  int get hashCode => state.hashCode ^ data.hashCode ^ error.hashCode;
}

enum UIState { loading, error, ok }
