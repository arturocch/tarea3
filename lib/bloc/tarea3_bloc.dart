import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarea_3_moviles/model/datos_tarea3.dart';

import '../repositorios/repositorio_tarea3.dart';

part 'tarea3_event.dart';
part 'tarea3_state.dart';

class Tarea3Bloc extends Bloc<Tarea3Event, Tarea3State> {
  Tarea3Bloc() : super(Tarea3Initial()) {
    on<clickOnSearch>(_search);
  }
}

FutureOr<void> _search(clickOnSearch event, emit) async {
  emit(searching());
  final repo = booksServices();
  print(event.searchData);

  try {
    BooksData? books_data = await repo.busquedaLibros(event.searchData);
    if (books_data != null) {
      emit(searchSucces(books_data: books_data));
    } else {
      emit(searchError(error: 'data empty'));
    }
  } catch (e) {
    emit(searchError(error: 'error'));
    return;
  }
}
