import 'package:dartz/dartz.dart';
import 'package:pokedex_app/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
