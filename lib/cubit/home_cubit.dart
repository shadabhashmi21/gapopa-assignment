import 'package:gapopa_assignment/cubit/base_cubit.dart';
import 'package:gapopa_assignment/cubit/states/home_states.dart';
import 'package:gapopa_assignment/log_helper.dart';
import 'package:gapopa_assignment/repository/home_repository.dart';
import 'package:gapopa_assignment/resources/app_constants.dart' as app_constants;

int currentPage = 1;
int totalPage = 1;
const nextPageApiCallThreshold = 10;

class HomeCubit extends BaseCubit {
  HomeCubit(this._repository);

  final HomeRepository _repository;
  final _tag = 'HomeCubit';
  bool _isHomeApiCalling = false;

  Future<void> onHomeScrollChange(
      final double scrollPositionInPixels,
      final double maxScrollExtent,
      ) async {
    try {
      if (_isHomeApiCalling) {
        return;
      }
      final scrollPercent = (scrollPositionInPixels * 100 / maxScrollExtent).round();
      if (scrollPercent >= nextPageApiCallThreshold) {
        if (currentPage < totalPage) {
          currentPage++;
          await fetchHomeData();
        }
      }
    } catch (e, s) {
      logE(_tag, message: e.toString(), stacktrace: s);
    }
  }

  Future<void> fetchHomeData({final bool firstCall = false}) async {
    _isHomeApiCalling = true;
    if(firstCall){
      emit(HomeLoadingState('Fetching data...'));
    }
    try {
      final response = await _repository.fetchHits(currentPage);
      if (response.isRight) {
        final homeResponse = response.right;

        totalPage = (homeResponse.totalHits! / app_constants.perPageQuery).ceil();

        emit(HomeSuccessState(data: homeResponse));
      } else {
        emit(HomeErrorPromptState(response.left ?? ''));
      }
    } catch (e, s) {
      logE(_tag, message: e.toString(), stacktrace: s);
      emit(HomeErrorPromptState('Something went wrong'));
    }
    _isHomeApiCalling = false;
  }
}
