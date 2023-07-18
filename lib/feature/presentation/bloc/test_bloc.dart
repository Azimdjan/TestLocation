import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/expections.dart';
import '../../../services/location_service.dart';
import '../../domain/usecase/get_location_usecase.dart';

part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final GetLocationUseCase getLocationUseCase;

  TestBloc(this.getLocationUseCase) : super(const TestState()) {
    on<TestInitializeEvent>(_initializeHandler);
    on<TestPositionChangedEvent>(_positionChangedHandler);
  }

  FutureOr<void> _initializeHandler(
      TestEvent event, Emitter<TestState> emit) async {
    emit(state.copyWith(status: TestStatus.loading));
    final position = await LocationService.getInstance().determinePosition();
    try {
      await getLocationUseCase((position.latitude, position.longitude)).then(
        (response) {
          emit(
            state.copyWith(
              addressName: response.name,
              myLocation: (position.latitude, position.longitude),
              status: TestStatus.success,
            ),
          );
        },
      );
    } catch (e) {
      if (e is NetworkException) {
        emit(
          state.copyWith(
            status: TestStatus.failure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TestStatus.failure,
          ),
        );
      }
    }
  }

  FutureOr<void> _positionChangedHandler(
      TestPositionChangedEvent event, Emitter<TestState> emit) async {
    emit(state.copyWith(status: TestStatus.loading));
    try {
      await getLocationUseCase((event.position.$1, event.position.$2)).then(
        (response) {
          emit(
            state.copyWith(
              addressName: response.name,
              status: TestStatus.success,
            ),
          );
        },
      );
    } catch (e) {
      if (e is NetworkException) {
        emit(
          state.copyWith(
            status: TestStatus.failure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TestStatus.failure,
          ),
        );
      }
    }
  }
}
