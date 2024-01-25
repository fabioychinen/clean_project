import 'package:clean_project/domain/failures/failures.dart';


import 'package:clean_project/domain/usecases/advicer_usecases.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:equatable/equatable.dart';


part 'advicer_state.dart';


const generalFailureMessage = 'Ups, something gone wrong. Please try again!';


const serverFailureMessage = 'Ups, API Error. please try again!';


const cacheFailureMessage = 'Ups, chache failed. Please try again!';


class AdvicerCubit extends Cubit<AdvicerCubitState> {

  final AdvicerUseCases adviceUseCases;


  AdvicerCubit({required this.adviceUseCases}) : super(const AdvicerInitial());


  void adviceRequested() async {

    emit(const AdvicerStateLoading());


    final failureOrAdvice = await adviceUseCases.getAdvice();


    failureOrAdvice.fold(

        (failure) =>

            emit(AdvicerStateError(message: _mapFailureToMessage(failure))),

        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));

  }


  String _mapFailureToMessage(Failure failure) {

    switch (failure.runtimeType) {

      case ServerFailure _:

        return serverFailureMessage;


      case CacheFailure _:

        return cacheFailureMessage;


      default:

        return generalFailureMessage;

    }

  }

}

