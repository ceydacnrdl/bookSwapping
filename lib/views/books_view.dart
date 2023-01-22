import '../models/book_model.dart';
import '../screens/chat_screen.dart';
import '../services/auth.dart';
import '../views/books_view_model.dart';
import '../views/update_book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'add_book_view.dart';
import 'package:animated_icon_button/animated_icon_button.dart';

class BooksView extends StatefulWidget {
  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BooksViewModel>(
      create: (_) => BooksViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () async {
              //Auth _auth = Auth();
              //_auth.signOut();
              Provider.of<Auth>(context, listen: false).signOut();
              print('logout tıklandı');
            },
            icon: Icon(Icons.logout),
          ),
        ]),
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Column(children: [
            StreamBuilder<List<Book>>(
              stream: Provider.of<BooksViewModel>(context, listen: false)
                  .getBookList(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  print(asyncSnapshot.error);
                  return Center(
                      child:
                          Text('Bir Hata Oluştu, daha sonra tekrar deneyiniz'));
                } else {
                  if (!asyncSnapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List<Book> kitapList = asyncSnapshot.data!;
                    return BuildListView(kitapList: kitapList); //, key: null,
                  }
                }
              },
            ),
            Divider(),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBookView()));
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    super.key,
    required this.kitapList,
  });

  final List<Book> kitapList;

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  bool isFiltering = false;
  late List<Book> filteredList;

  @override
  Widget build(BuildContext context) {
    var fullList = widget.kitapList;
    return Container(
      child: Flexible(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Arama: Kitap adı',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    isFiltering = true;

                    setState(() {
                      filteredList = fullList
                          .where((book) => book.bookName
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    });
                  } else {
                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
                    setState(() {
                      isFiltering = false;
                    });
                  }
                },
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount:
                      isFiltering ? filteredList.length : fullList.length,
                  itemBuilder: (context, index) {
                    var list = isFiltering ? filteredList : fullList;
                    return Slidable(
                      child: Card(
                        child: ListTile(
                          title: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          'Book Name       ' +
                                              list[index].bookName,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue)),
                                      Text(
                                          'Author Name       ' +
                                              list[index].authorName,
                                          style: TextStyle(fontSize: 18)),
                                      Text(
                                          'Offered Book      ' +
                                              list[index].istenilenKitap,
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                          subtitle: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (Column(
                                  children: <Widget>[
                                    ElevatedButton(
                                        child: Text("Send offer"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen()));
                                        }),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) async {
                              await Provider.of<BooksViewModel>(context,
                                      listen: false)
                                  .deleteBook(list[index]);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateBookView(book: list[index])));
                            },
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
