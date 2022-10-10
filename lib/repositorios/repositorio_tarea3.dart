import 'package:http/http.dart' as http;
import 'package:tarea_3_moviles/model/datos_tarea3.dart';

class booksServices {
  final String url = ('https://www.googleapis.com/books/v1/volumes?q=');

  Future<BooksData?> busquedaLibros(String busqueda) async {
    Uri urlLibro = Uri.parse(url + busqueda);
    var response = await http.get(urlLibro);
    print(response.statusCode);
    try {
      BooksData? responseBody = booksDataFromJson(response.body);
      return responseBody;
    } catch (e) {
      return null;
    }
  }
}
