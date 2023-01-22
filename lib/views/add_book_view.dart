import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../services/calculator.dart';
import '../views/add_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookView extends StatefulWidget {
  @override
  _AddBookViewState createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
// void initState() {
//     FirebaseAuth.instance.userChanges().listen((event) {
//       print(FirebaseAuth.instance.currentUser);
//       print(event);
//     });
//   }

  TextEditingController bookCtr = TextEditingController();
  TextEditingController authorCtr = TextEditingController();
  TextEditingController publishCtr = TextEditingController();
  TextEditingController istenilenKitapCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _selectedDate;

  @override
  void dispose() {
    bookCtr.dispose();
    authorCtr.dispose();
    publishCtr.dispose();
    istenilenKitapCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookViewModel>(
      create: (_) => AddBookViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: Text('Yeni Kitap Ekle')),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    controller: bookCtr,
                    decoration: InputDecoration(
                        hintText: 'Kitap Adı', icon: Icon(Icons.book)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kitap Adı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: authorCtr,
                    decoration: InputDecoration(
                        hintText: 'Yazar Adı', icon: Icon(Icons.edit)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Yazar Adı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: istenilenKitapCtr,
                    decoration: InputDecoration(
                        hintText: 'İstenilen Kitap', icon: Icon(Icons.edit)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Takas Etmek İstediğiniz Kitabı Giriniz.';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Kaydet'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      /// kulanıcı bilgileri ile addNewBook metodu çağırılacak,
                      await context.read<AddBookViewModel>().addNewBook(
                            bookName: bookCtr.text,
                            authorName: authorCtr.text,
                            istenilenKitap: istenilenKitapCtr.text,
                            id: FirebaseAuth.instance.currentUser!.uid,
                          );

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(
                            FirebaseAuth.instance.currentUser!.uid,
                          )
                          .set({
                        'books': {
                          'bookId': [FirebaseAuth.instance.currentUser!.uid],
                          'bookname': [bookCtr.text]
                        },
                        'email': FirebaseAuth.instance.currentUser!.uid,
                        'userId': FirebaseAuth.instance.currentUser!.uid
                      });

                      /// navigator.pop
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
