import 'package:bloc/bloc.dart';
import 'package:gapopa_assignment/cubit/states/data_state.dart';

abstract class BaseCubit extends Cubit<DataState> {
  BaseCubit() : super(InitialState());
}