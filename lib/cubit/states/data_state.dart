import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {}

class InitialState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadingState extends DataState {
  LoadingState(this._loadingMessage);

  final String? _loadingMessage;

  String get loadingMessage => _loadingMessage ?? 'loading...';

  @override
  List<String?> get props => [loadingMessage];
}

class SuccessState<T> extends DataState {
  SuccessState({required this.data, this.message});

  final String? message;
  final T? data;

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SuccessListState<T> extends DataState with EquatableMixin {
  SuccessListState({required this.data, this.message});

  final String? message;
  final List<T> data;

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ErrorState extends DataState {
  ErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}

class ErrorPromptState extends DataState {
  ErrorPromptState(this.errorMessage);

  final String errorMessage;
  final String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  List<String> get props => [errorMessage, uniqueId];
}
