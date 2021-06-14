import 'package:tubes_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/providers/provider_book.dart';

class FormBook extends StatefulWidget {
  Book book;
  final String id;
  final String kategori;
  final String namaBuku;
  final String penerbit;
  final String penulis;
  final int jumlah;

  FormBook(this.id, this.kategori, this.namaBuku, this.penerbit, this.penulis,
      this.jumlah);

  @override
  _FormBookState createState() => _FormBookState(this.id, this.kategori,
      this.namaBuku, this.penerbit, this.penulis, this.jumlah);
}

class _FormBookState extends State<FormBook> {
  TextEditingController idController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController namaBukuController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController jumlahBukuController = TextEditingController();
  @override
  void dispose() {
    kategoriController.dispose();
    namaBukuController.dispose();
    penerbitController.dispose();
    penulisController.dispose();
    jumlahBukuController.dispose();
    super.dispose();
  }

  _FormBookState(String id, String kategori, String namaBuku, String penerbit,
      String penulis, int jumlah) {
    idController.text = id;
    kategoriController.text = kategori;
    namaBukuController.text = namaBuku;
    penerbitController.text = penerbit;
    penulisController.text = penulis;
    jumlahBukuController.text = jumlah.toString();
  }

  @override
  void initState() {
    if (idController.text == null) {
      //New Record
      kategoriController.text = "";
      namaBukuController.text = "";
      penerbitController.text = "";
      penulisController.text = "";
      jumlahBukuController.text = "";
      // new Future.delayed(Duration.zero, () {
      //   final bookProvider = Provider.of<BookProvider>(context, listen: false);
      //   bookProvider.loadValues(Book());
      // });
    } else {
      //Controller Update
      kategoriController.text = widget.book.kategori.toString();
      namaBukuController.text = widget.book.namaBuku.toString();
      penerbitController.text = widget.book.penerbit.toString();
      penulisController.text = widget.book.penulis.toString();
      jumlahBukuController.text = widget.book.jumlahBuku.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final bookProvider = Provider.of<BookProvider>(context, listen: false);
        bookProvider.loadValues(
            idController.text,
            kategoriController.text,
            namaBukuController.text,
            penerbitController.text,
            penulisController.text,
            int.parse(jumlahBukuController.text));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Buku')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: namaBukuController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Buku',
                  prefixIcon: Icon(Icons.assignment_ind_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  bookProvider.changeNamaBuku(value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: kategoriController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Kategori Buku',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => bookProvider.changeKategori(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: penulisController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Penulis',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => bookProvider.changePenulis(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: penerbitController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Penerbit',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => bookProvider.changePenerbit(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: jumlahBukuController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'JumlahBuku',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  bookProvider.changeJumlahBuku(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColorLight,
                onPressed: () {
                  bookProvider.saveBook();
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('SAVE')),
              ),
            ),
            (widget.book != null)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        bookProvider.removeBook(widget.book.idBuku);
                        Navigator.of(context).pop();
                      },
                      child: Center(child: Text('DELETE')),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
