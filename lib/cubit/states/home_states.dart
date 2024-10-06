import 'package:gapopa_assignment/cubit/states/data_state.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';

/// Represents the loading state specific to the Home screen.
///
/// This state extends [LoadingState] and is used when the Home screen
/// is in the process of loading data. It inherits the loading message from
/// the [LoadingState] class.
class HomeLoadingState extends LoadingState {
  /// Constructs a [HomeLoadingState] with an optional loading message.
  HomeLoadingState(super.loadingMessage);
}

/// Represents an error state specific to the Home screen.
///
/// This state is only called if there is an error during the API call for the first time.
///
/// This state extends [ErrorState] and is used when an error occurs
/// while loading data for the Home screen.
///
/// - [errorMessage]: The message describing the error encountered.
class HomeErrorState extends ErrorState {
  /// Constructs a [HomeErrorState] with a specified error message.
  HomeErrorState(super.errorMessage);
}

/// Represents an error prompt state specific to the Home screen.
///
/// This state is only called if there is an error during the API call after the first time.
///
/// This state extends [ErrorPromptState] and is used to display
/// error messages to the user on the Home screen.
///
/// - [errorMessage]: The message describing the error encountered.
class HomeErrorPromptState extends ErrorPromptState {
  /// Constructs a [HomeErrorPromptState] with a specified error message.
  HomeErrorPromptState(super.errorMessage);
}

/// Represents a successful data state specific to the Home screen.
///
/// This state extends [SuccessState] with a specific type, 
/// [PixabayResponse], indicating that the Home screen has successfully
/// loaded data.
///
/// - [data]: The successfully loaded [PixabayResponse] object.
class HomeSuccessState extends SuccessState<PixabayResponse> {
  /// Constructs a [HomeSuccessState] with the specified data.
  HomeSuccessState({required super.data});
}