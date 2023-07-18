part of 'test_bloc.dart';

class TestState extends Equatable {
  final String? addressName;
  final (double lat, double long)? myLocation;
  final TestStatus status;

  const TestState({
    this.addressName,
    this.myLocation,
    this.status = TestStatus.idle,
  });

  TestState copyWith({
    String? addressName,
    (double lat, double long)? myLocation,
    TestStatus? status,
  }) {
    return TestState(
      addressName: addressName ?? this.addressName,
      myLocation: myLocation ?? this.myLocation,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [addressName, myLocation, status];
}

enum TestStatus { idle, loading, success, failure }

extension TestStatusX on TestStatus {
  bool get isIdle => this == TestStatus.idle;

  bool get isLoading => this == TestStatus.loading;

  bool get isSuccess => this == TestStatus.success;

  bool get isFailure => this == TestStatus.failure;
}
