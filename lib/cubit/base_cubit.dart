import 'package:bloc/bloc.dart';
import 'package:gapopa_assignment/cubit/states/data_state.dart';

/// An abstract base class for all Cubit classes in the application.
///
/// This class extends [Cubit] and is initialized with an [InitialState].
/// It provides a foundation for other Cubit classes, ensuring they
/// all start with a default state.
abstract class BaseCubit extends Cubit<DataState> {
  /// Constructs a [BaseCubit] and initializes the state to [InitialState].
  BaseCubit() : super(InitialState());
}