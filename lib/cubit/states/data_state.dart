import 'package:equatable/equatable.dart';

/// An abstract class representing the various states of data in the application.
///
/// The [DataState] class extends [Equatable] to enable comparison between
/// different states based on their properties.
abstract class DataState extends Equatable {}

/// Represents the initial state of the data.
///
/// This state is used when the application has not yet loaded any data.
class InitialState extends DataState {
  @override
  List<Object> get props => [];
}

/// Represents the loading state of the data.
///
/// This state is used when the application is in the process of loading data.
///
/// - [loadingMessage]: An optional message that describes the loading status.
class LoadingState extends DataState {
  LoadingState(this._loadingMessage);

  final String? _loadingMessage;

  /// Returns the loading message, defaulting to 'loading...' if none is provided.
  String get loadingMessage => _loadingMessage ?? 'loading...';

  @override
  List<String?> get props => [loadingMessage];
}

/// Represents the successful state of the data.
///
/// This state indicates that data has been successfully loaded.
///
/// - [data]: The loaded data, which can be of any type.
/// - [message]: An optional message associated with the successful load.
class SuccessState<T> extends DataState {
  SuccessState({required this.data, this.message});

  final String? message; // An optional message related to the successful load.
  final T? data;  // The successfully loaded data.

  @override
  List<Object?> get props => [identityHashCode(this)]; // Properties used for comparison.
}

/// Represents the error state of the data.
///
/// This state is used when an error occurs during data loading.
///
/// - [errorMessage]: The message describing the error encountered.
class ErrorState extends DataState {
  ErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}

/// Represents a state that prompts the user with an error message.
///
/// This state is used when an error needs to be prompted to the user.
///
/// - [errorMessage]: The message describing the error encountered.
/// - [uniqueId]: A unique identifier for the error prompt, based on the current timestamp.
class ErrorPromptState extends DataState {
  ErrorPromptState(this.errorMessage);

  final String errorMessage; // The error message to display.
  final String uniqueId = DateTime.now().millisecondsSinceEpoch.toString(); // Unique identifier for this error prompt.

  @override
  List<String> get props => [errorMessage, uniqueId]; // Properties used for comparison.
}
