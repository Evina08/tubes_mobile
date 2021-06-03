import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_flutter/models/anggota.dart';
import 'package:tubes_flutter/models/book.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //anggota
  Future<void> saveAnggota(Anggota anggota) {
    return _db
        .collection('anggota')
        .doc(anggota.idAnggota)
        .set(anggota.toMap());
  }

  Stream<List<Anggota>> getAnggota() {
    return _db.collection('anggota').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Anggota.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeAnggota(String idAnggota) {
    return _db.collection('anggota').doc(idAnggota).delete();
  }

  //book
  Future<void> saveBook(Book book) {
    return _db.collection('book').doc(book.idBuku).set(book.toMap());
  }

  Stream<List<Book>> getBook() {
    return _db.collection('book').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Book.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeBook(String idBuku) {
    return _db.collection('book').doc(idBuku).delete();
  }
}
