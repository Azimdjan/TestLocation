part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();
}

class TestInitializeEvent extends TestEvent {
  const TestInitializeEvent();

  @override
  List<Object> get props => [];
}

class TestPositionChangedEvent extends TestEvent {
  final (double lat, double long) position;

  const TestPositionChangedEvent(this.position);

  @override
  List<Object> get props => [position];
}
