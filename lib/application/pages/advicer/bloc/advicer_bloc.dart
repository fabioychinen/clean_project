import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';


part 'advicer_event.dart';


part 'advicer_state.dart';


class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {

  AdvicerBloc() : super(AdvicerInitial()) {

    on<AdvicerEvent>((event, emit) async {

      emit(AdvicerStateLoading());


      debugPrint('Fake get advice triggered');


      await Future.delayed(const Duration(seconds: 3), () {});


      debugPrint('Got advice');


      emit(AdvicerStateLoaded(advice: 'fake advice to test bloc'));


      //emit(AdvicerStateError(message: 'Error message'));

    });

  }

}

