import 'package:gapopa_assignment/network/network_service.dart';

/// An abstract base class for all repositories that require network access.
///
/// The [BaseRepository] class provides a common `networkService` instance
/// that can be used by derived repositories to perform network operations.
///
/// This class should be extended by specific repositories that need to interact
/// with APIs or other network-based services.
abstract class BaseRepository{
  /// An instance of [NetworkService] to handle network requests.
  ///
  /// This service is shared by all repositories that extend [BaseRepository]
  /// and provides a way to perform network-related operations.
  final networkService = NetworkService();
}