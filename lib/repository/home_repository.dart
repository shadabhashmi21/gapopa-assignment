import 'package:either_dart/either.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';
import 'package:gapopa_assignment/repository/base_repository.dart';
import 'package:gapopa_assignment/resources/app_constants.dart' as app_constants;

class HomeRepository extends BaseRepository {
  Future<Either<String?, PixabayResponse>> fetchHits({
    required final int pageNumber,
    final int pagePerQuery = app_constants.perPageQuery,
  }) async {
    try {
      final response = await networkService.get(
        'api/?key=${app_constants.apiKey}&page=$pageNumber&per_page=$pagePerQuery}',
      );
      return Right(PixabayResponse.fromJson(response as Map<String, dynamic>));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
