import 'package:flutter/material.dart';

/// A widget that displays a loading indicator with an optional message,
/// while an API call is in progress
/// - [loadingText] (optional): A message to display above the loading spinner.
class APILoadingWidget extends StatelessWidget {
  const APILoadingWidget({super.key, this.loadingText});

  /// An optional loading message
  final String? loadingText;

  @override
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (loadingText != null) ...[
          Text(
            loadingText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
        ],
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    ),
  );
}

/// A widget that displays an error message with an optional retry button,
/// when there is an error in API call
/// - [error]: The error message to display.
/// - [onRetryPressed] (optional): The callback function to execute when the retry button is pressed.
/// - [showRetry]: A flag indicating whether to show the retry button. Defaults to false.
class APIErrorWidget extends StatelessWidget {
  const APIErrorWidget({required this.error, super.key, this.onRetryPressed, this.showRetry = false});

  /// The error message to display.
  final String error;

  /// An optional callback function that is executed when the retry button is pressed.
  final VoidCallback? onRetryPressed;

  /// Whether to show the retry button. Defaults to false.
  final bool showRetry;

  @override
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        if (showRetry) ...[
          const SizedBox(height: 8),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.grey),
            ),
            child: const Text(
              'Retry',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => onRetryPressed?.call(),
          ),
        ],
      ],
    ),
  );
}

/// A widget that represents an empty state, where no content or data is available.
class APIEmptyWidget extends StatelessWidget {
  const APIEmptyWidget({super.key});

  @override
  Widget build(final BuildContext context) => const SizedBox(
    height: 0,
    width: 0,
  );
}