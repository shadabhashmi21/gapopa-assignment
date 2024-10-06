import 'package:either_dart/either.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';
import 'package:gapopa_assignment/repository/base_repository.dart';
import 'package:gapopa_assignment/resources/app_constants.dart' as app_constants;

/// A repository for fetching images from the Pixabay API.
///
/// The [HomeRepository] extends [BaseRepository] and provides methods to interact
/// with the Pixabay API to fetch image hits based on pagination.
class HomeRepository extends BaseRepository {
  /// Calls the Pixabay API.
  ///
  /// This method retrieves a paginated list of image hits from the API.
  /// It accepts [pageNumber] to specify the current page and an optional
  /// [pagePerQuery] parameter to control the number of items per page.
  ///
  /// Returns:
  /// - [Right] containing a [PixabayResponse] object on success.
  /// - [Left] containing an error message on failure.
  Future<Either<String?, PixabayResponse>> fetchHits({
    required final int pageNumber,
    final int pagePerQuery = app_constants.perPageQuery,
  }) async {
    try {
      final response = await networkService.get(
        'api/?key=${app_constants.apiKey}&page=$pageNumber&per_page=$pagePerQuery}',
      );

      // Return the successful response wrapped in a Right.
      return Right(PixabayResponse.fromJson(response as Map<String, dynamic>));
    } catch (e) {
      // Return the error message wrapped in a Left.
      return Left(e.toString());
    }
  }
}
