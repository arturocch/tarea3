import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tarea_3_moviles/model/datos_tarea3.dart';
import '../bloc/tarea3_bloc.dart';

class homePage extends StatelessWidget {
  homePage({super.key});
  final _searchController = TextEditingController();
  final _placeholder = 'ingrese palabra para buscar libro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Libreria free to play'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        BlocProvider.of<Tarea3Bloc>(context).add(
                            clickOnSearch(searchData: _searchController.text));
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Ingresa titulo'),
              ),
            ),
            BlocConsumer<Tarea3Bloc, Tarea3State>(listener: (context, state) {
              if (state is Tarea3Initial) {}
              if (state is searchSucces) {}
              if (state is searchError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('error, ${state.error}')),
                );
              }
            }, builder: (context, state) {
              if (state is searching) {
                return _loadingGrid(context);
              } else if (state is searchSucces) {
                return _bookGrid(
                    context,
                    state
                        .books_data); //return _booksGridView(context, state, this._searchController);
              } else
                return Center(child: Text(_placeholder)); //_defaultView(
              // context, this._mainMsg, this._searchController);
            }),
          ],
        ));
  }

  Widget _loadingGrid(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2.5;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: GridView.count(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            shrinkWrap: true,
            padding: EdgeInsets.all(6),
            children: List.generate(4, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  Container(
                    height: 15,
                    color: Colors.white,
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  Container(
                    width: itemWidth / 2.5,
                    height: 15,
                    color: Colors.white,
                  )
                ],
              );
            })),
      ),
    );
  }

  Widget _bookGrid(BuildContext context, BooksData books_data) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: GridView.count(
          childAspectRatio: (itemWidth / itemHeight),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(books_data.items.length, (index) {
            return book_mini(context, books_data.items[index]);
          })),
    );
  }

  Widget book_mini(BuildContext context, Item item) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                //event clickonbook
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      item.volumeInfo!.imageLinks!.thumbnail!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            'assets/images/no_cover_available.png',
                            fit: BoxFit.contain);
                      },
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      Container(
                          height: 40,
                          child: Text(item.volumeInfo!.title!,
                              overflow: TextOverflow.ellipsis, maxLines: 2))
                    ]),
                  )
                ],
              ),
            )));
  }
}
