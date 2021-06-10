import 'package:flutter/material.dart';
import 'package:tubes_flutter/services/firestore_service.dart';
import 'package:tubes_flutter/services/sign_in.dart';
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
  String _createdBy;
  var uuid = Uuid();

  //Getters
  String get kategori => _kategori;
  String get namaBuku => _namaBuku;
  String get penerbit => _penerbit;
  String get penulis => _penulis;
  int get jumlahBuku => _jumlahBuku;
  String get createdBy => _createdBy;
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

  changeCreatedBy(String value) {
    _createdBy = UsersId;
    notifyListeners();
  }

  //read
  loadValues(Book book) {
    _idBuku = book.idBuku;
    _namaBuku = book.namaBuku;
    _kategori = book.kategori;
    _penerbit = book.penerbit;
    _penulis = book.penulis;
    _jumlahBuku = book.jumlahBuku;
    _createdBy = book.createdBy;
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
          createdBy: UsersId,
          idBuku: uuid.v4());
      firestoreService.saveBook(newBook);
    } else {
      //Update
      var updatedBook = Book(
          kategori: _kategori,
          namaBuku: _namaBuku,
          penerbit: _penerbit,
          penulis: _penulis,
          jumlahBuku: _jumlahBuku,
          createdBy: _createdBy,
          idBuku: _idBuku);
      firestoreService.saveBook(updatedBook);
    }
  }

//delete
  removeBook(String idBuku) {
    firestoreService.removeBook(idBuku);
  }
}
