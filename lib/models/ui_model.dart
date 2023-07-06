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
}

enum UIState { loading, error, ok }
