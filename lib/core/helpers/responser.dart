part of 'helpers.dart';

abstract class Responser<T> {
  final T data;
  final String error;
  const Responser(this.data, this.error);

  bool get isSuccess;
  bool get isFailed;
}

class Success<T> implements Responser<T> {
  final T _data;
  const Success(this._data);

  @override
  bool get isFailed => false;

  @override
  bool get isSuccess => true;

  @override
  T get data => _data;

  @override
  String get error => throw UnimplementedError();
}

class Failed<T> implements Responser<T> {
  final String _error;
  Failed(this._error) {
    log(_error);
  }

  @override
  bool get isFailed => true;

  @override
  bool get isSuccess => false;

  @override
  T get data => throw UnimplementedError();

  @override
  String get error => _error;
}
