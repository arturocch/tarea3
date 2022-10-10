part of 'tarea3_bloc.dart';

abstract class Tarea3Event extends Equatable {
  const Tarea3Event();

  @override
  List<Object> get props => [];
}

class clickOnSearch extends Tarea3Event {
  final searchData;

  clickOnSearch({required this.searchData});
  @override
  List<Object> get props => [searchData];
}
