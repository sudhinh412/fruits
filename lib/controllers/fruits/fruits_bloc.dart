import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/model/Fruits.dart';
import 'package:fruits/services/apiservices.dart';
import 'package:dio/dio.dart';

part 'fruits_event.dart';
part 'fruits_state.dart';

class FruitsBloc extends Bloc<FruitsEvent, FruitsState> {


  FruitsBloc() : super(FruitsInitial()) {
    on<LoadFruits>((event, emit) async {
      emit(FruitsLoading());
      try {
        final fruits = await ApiService().getFruits();
        emit(FruitsLoaded(fruits));
      } on DioException catch (e) {
        String message = "An error occurred";
        if (e.type == DioExceptionType.connectionError || 
            e.message?.contains('Failed host lookup') == true) {
          message = "No Internet Connection";
        } else if (e.response != null) {
          message = "Server Error: ${e.response?.statusCode}";
        }
        emit(FruitsError(message));
      } catch (e) {
        emit(FruitsError(e.toString()));
      }
    });
  }
}
