import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_flutter/models/anggota.dart';
import 'package:tubes_flutter/models/book.dart';
import 'package:tubes_flutter/services/sign_in.dart';

class FirestoreService {
  CollectionReference _dbbook = FirebaseFirestore.instance.collection('book');
  CollectionReference _dbanggota =
      FirebaseFirestore.instance.collection('anggota');
  //anggota
  Future<void> saveAnggota(Anggota anggota) {
    return _dbanggota.doc(anggota.idAnggota).set(anggota.toMap());
  }

  Stream<List<Anggota>> getAnggota() {
    return _dbanggota
        .where('createdBy', isEqualTo: uid)
        //.orderBy('idAnggota')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Anggota.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeAnggota(String idAnggota) {
    return _dbanggota.doc(idAnggota).delete();
  }

  //book
  Future<void> saveBook(Book book) {
    return _dbbook.doc(book.idBuku).set(book.toMap());
  }

  Stream<List<Book>> getBook() {
    return _dbbook
        .where('createdBy', isEqualTo: uid)
        //.orderBy('idBuku')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Book.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeBook(String idBuku) {
    return _dbbook.doc(idBuku).delete();
  }
}
