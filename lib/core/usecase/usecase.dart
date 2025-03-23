import 'package:fpdart/fpdart.dart';
import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';

abstract class Usecase<T, P extends Params> {
  TaskEither<Failure, T> build(P params);
}
