import 'package:gapopa_assignment/cubit/states/data_state.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';

class HomeLoadingState extends LoadingState {
  HomeLoadingState(super.loadingMessage);
}

class HomeErrorState extends ErrorState {
  HomeErrorState(super.errorMessage);
}

class HomeErrorPromptState extends ErrorPromptState {
  HomeErrorPromptState(super.errorMessage);
}

class HomeSuccessState extends SuccessState<PixabayResponse> {
  HomeSuccessState({required super.data});
}