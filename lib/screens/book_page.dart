import 'package:flutter/material.dart';
import 'package:tubes_flutter/screens/form_book.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/models/book.dart';
import 'package:tubes_flutter/providers/provider_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_flutter/services/sign_in.dart';

class BookPage extends StatefulWidget {
  final Book book;

  BookPage([this.book]);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<List<Book>>(context);
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Buku'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_to_photos_sharp,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        FormBook(null, null, null, null, null, null),
                  ),
                );
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('book')
                .where('createdBy', isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.book_outlined),
                            ),
                            title: Text(data['namaBuku']),
                            // trailing: Text(
                            //   anggota[index].jenisMember,
                            // ),
                            subtitle: Text("Kategori: " +
                                data['kategori'] +
                                "  Jumlah Buku: " +
                                data['jumlahBuku'].toString()),
                            trailing: GestureDetector(
                              child: Icon(Icons.delete_sweep_rounded),
                              onTap: () {
                                bookProvider.removeBook(widget.book.idBuku);
                                Navigator.of(context).pop();
                              },
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FormBook(
                                    data.id.toString(),
                                    data['kategori'].toString(),
                                    data['namaBuku'].toString(),
                                    data['penerbit'].toString(),
                                    data['penulis'].toString(),
                                    data['jumlahBuku'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
            }));
  }
}
