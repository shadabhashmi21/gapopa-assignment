import 'package:either_dart/either.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';
import 'package:gapopa_assignment/network/network_service.dart';
import 'package:gapopa_assignment/resources/app_constants.dart' as app_constants;

class HomeRepository {
  HomeRepository(this._networkService);

  final NetworkService _networkService;

  Future<Either<String?, PixabayResponse>> fetchHits(final int pageNumber) async {
    try {
      final response = await _networkService.get('api/?key=${app_constants.apiKey}&page=$pageNumber');
      return Right(PixabayResponse.fromJson(response as Map<String, dynamic>));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
