import 'package:flutter/material.dart';

class APILoadingWidget extends StatelessWidget {
  const APILoadingWidget({super.key, this.loadingText});

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

class APIErrorWidget extends StatelessWidget {
  const APIErrorWidget({required this.error, super.key, this.onRetryPressed, this.showRetry = false});

  final String error;
  final VoidCallback? onRetryPressed;
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

class APIEmptyWidget extends StatelessWidget {
  const APIEmptyWidget({super.key});

  @override
  Widget build(final BuildContext context) => const SizedBox(
    height: 0,
    width: 0,
  );
}