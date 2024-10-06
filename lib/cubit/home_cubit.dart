import 'package:gapopa_assignment/cubit/base_cubit.dart';
import 'package:gapopa_assignment/cubit/states/home_states.dart';
import 'package:gapopa_assignment/log_helper.dart';
import 'package:gapopa_assignment/repository/home_repository.dart';
import 'package:gapopa_assignment/resources/app_constants.dart' as app_constants;
import 'package:gapopa_assignment/resources/app_extensions.dart';
import 'package:gapopa_assignment/resources/app_strings.dart' as app_strings;

// Global variables for pagination control.
int currentPage = 1; // it shows the current page number
int totalPage = 1; // it shows the total number of pages
const _nextPageApiCallThreshold = 50; // this shows the next page will be called when 50% of the current page has been scrolled

/// The HomeCubit class manages the state of the home screen in the application.
///
/// It extends [BaseCubit] and is responsible for fetching and managing
/// data related to the home screen. It handles pagination and scroll events
/// to load more data when the user scrolls to the bottom of the list.
class HomeCubit extends BaseCubit {
  /// Constructs a [HomeCubit] with the given [HomeRepository].
  HomeCubit(this._repository);

  final HomeRepository _repository; // Repository for fetching home data.
  final _tag = 'HomeCubit'; // Tag for logging purposes.
  bool _isHomeApiCalling = false; // Flag to prevent multiple API calls.

  /// Handles the scroll change event to load more data when the user reaches
  /// the threshold while scrolling.
  ///
  /// Takes the current scroll position in pixels and the maximum scroll extent.
  Future<void> onHomeScrollChange(
    final double scrollPositionInPixels,
    final double maxScrollExtent,
  ) async {
    try {
      // Prevent multiple API calls while one is in progress.
      // If the API call is still under progress then just return and stop the execution
      if (_isHomeApiCalling) {
        return;
      }

      // Calculate the percentage of scrolling
      final scrollPercent = (scrollPositionInPixels * 100 / maxScrollExtent).round();

      // If the scroll percentage exceeds the threshold, fetch more data.
      if (scrollPercent >= _nextPageApiCallThreshold) {
        // Check if current page is not the last page available
        if (currentPage < totalPage) {
          // if current page is smaller than the total page
          // increment the current page and call the API to fetch data again
          currentPage++;
          await fetchHomeData();
        }
      }
    } catch (e, s) {
      logE(_tag, message: e.toString(), stacktrace: s);
    }
  }

  /// Fetches home data from the repository.
  ///
  /// Can be called for the first time or for subsequent data loads.
  /// pass [firstCall] as 'true' if the API is getting called for the first time.
  Future<void> fetchHomeData({final bool firstCall = false}) async {
    _isHomeApiCalling = true; // Set flag to indicate API call in progress.

    // Emit loading state if this is the first call.
    if (firstCall) {
      emit(HomeLoadingState('Fetching data...'));
    }
    try {
      // Fetch data from the repository.
      final response = await _repository.fetchHits(pageNumber: currentPage);
      if (response.isRight) {
        final homeResponse = response.right;

        // Calculate total pages based on total hits and per page query.
        homeResponse.totalHits?.let((final totalHits) => totalPage = (totalHits / app_constants.perPageQuery).ceil());

        // Emit success state with fetched data.
        emit(HomeSuccessState(data: homeResponse));
      } else {
        // if the currentPage is 1 the show an error state,
        // which will show an error on the whole screen
        if (currentPage == 1) {
          emit(HomeErrorState(response.left ?? app_strings.genericError));
        } else {
          // otherwise just show an error below the fetched data on the screen
          emit(HomeErrorPromptState(response.left ?? app_strings.genericError));
        }
      }
    } catch (e, s) {
      logE(_tag, message: e.toString(), stacktrace: s);
      // if the currentPage is 1 the show an error state,
      // which will show an error on the whole screen
      if (currentPage == 1) {
        emit(HomeErrorState(app_strings.genericError));
      } else {
        // otherwise just show an error below the fetched data on the screen
        emit(HomeErrorPromptState(app_strings.genericError));
      }
    }
    _isHomeApiCalling = false; // Reset the API calling flag.
  }
}
