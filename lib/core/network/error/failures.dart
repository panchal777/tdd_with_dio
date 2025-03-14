import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.errorMessage, this.statusCode);
}
class CancelTokenFailure extends Failure {
  final int? statusCode;

  const CancelTokenFailure(super.errorMessage, this.statusCode);
}
