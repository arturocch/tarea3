part of 'tarea3_bloc.dart';

abstract class Tarea3State extends Equatable {
  const Tarea3State();

  @override
  List<Object> get props => [];
}

class Tarea3Initial extends Tarea3State {}

class searching extends Tarea3State {}

class searchSucces extends Tarea3State {
  final BooksData books_data;

  searchSucces({required this.books_data});
  @override
  List<Object> get props => [books_data];
}

class searchError extends Tarea3State {
  final String error;

  searchError({required this.error});
  @override
  List<Object> get props => [error];
}
