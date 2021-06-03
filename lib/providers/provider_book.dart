import 'package:flutter/material.dart';
import 'package:tubes_flutter/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:tubes_flutter/models/book.dart';

class BookProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _idBuku;
  String _kategori;
  String _namaBuku;
  String _penerbit;
  String _penulis;
  int _jumlahBuku;
  var uuid = Uuid();

  //Getters
  String get kategori => _kategori;
  String get namaBuku => _namaBuku;
  String get penerbit => _penerbit;
  String get penulis => _penulis;
  int get jumlahBuku => _jumlahBuku;

  //Setters

  changeJumlahBuku(String value) {
    _jumlahBuku = int.parse(value);
    notifyListeners();
  }

  changeKategori(String value) {
    _kategori = value;
    notifyListeners();
  }

  changeNamaBuku(String value) {
    _namaBuku = value;
    notifyListeners();
  }

  changePenulis(String value) {
    _penulis = value;
    notifyListeners();
  }

  changePenerbit(String value) {
    _penerbit = value;
    notifyListeners();
  }

  //read
  loadValues(Book book) {
    _namaBuku = book.namaBuku;
    _kategori = book.kategori;
    _penerbit = book.penerbit;
    _penulis = book.penulis;
    _jumlahBuku = book.jumlahBuku;
  }

//create/update
  saveBook() {
    print(_idBuku);
    if (_idBuku == null) {
      var newBook = Book(
          kategori: kategori,
          namaBuku: namaBuku,
          penerbit: penerbit,
          penulis: penulis,
          jumlahBuku: jumlahBuku,
          idBuku: uuid.v4());
      firestoreService.saveBook(newBook);
    } else {
      //Update
      var updatedBook = Book(
          kategori: kategori,
          namaBuku: namaBuku,
          penerbit: penerbit,
          penulis: penulis,
          jumlahBuku: jumlahBuku,
          idBuku: _idBuku);
      firestoreService.saveBook(updatedBook);
    }
  }

//delete
  removeBook(String idBuku) {
    firestoreService.removeBook(idBuku);
  }
}
