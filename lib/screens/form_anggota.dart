import 'package:tubes_flutter/models/anggota.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/providers/provider_anggota.dart';

class FormAnggota extends StatefulWidget {
  Anggota anggota;
  final String idAnggota;
  final String namaAnggota;
  final String jenisMember;
  final int nik;
  final int umur;

  FormAnggota(
      this.idAnggota, this.namaAnggota, this.jenisMember, this.nik, this.umur);
  @override
  _FormAnggotaState createState() => _FormAnggotaState(
      this.idAnggota, this.namaAnggota, this.jenisMember, this.nik, this.umur);
}

class _FormAnggotaState extends State<FormAnggota> {
  TextEditingController idAnggotaController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController namaAnggotaController = TextEditingController();
  TextEditingController jenisMemberController = TextEditingController();
  String check;
  @override
  void dispose() {
    nikController.dispose();
    umurController.dispose();
    namaAnggotaController.dispose();
    jenisMemberController.dispose();
    super.dispose();
  }

  _FormAnggotaState(String idAnggota, String namaAnggota, String jenisMember,
      int nik, int umur) {
    if (jenisMember != null) {
      idAnggotaController.text = idAnggota;
      nikController.text = nik.toString();
      umurController.text = umur.toString();
      namaAnggotaController.text = namaAnggota;
      jenisMemberController.text = jenisMember;
      check = "ada";
    } else {
      check = "kosong";
    }
  }
  @override
  void initState() {
    if (check == "kosong") {
      //New Record
      nikController.text = "";
      umurController.text = "";
      namaAnggotaController.text = "";
      jenisMemberController.text = "";
      // new Future.delayed(Duration.zero, () {
      //   final anggotaProvider =
      //       Provider.of<AnggotaProvider>(context, listen: false);
      //   anggotaProvider.loadValues(Anggota());
      // });
    } else {
      //Controller Update
      // nikController.text = widget.anggota.nik.toString();
      // umurController.text = widget.anggota.umur.toString();
      // namaAnggotaController.text = widget.anggota.namaAnggota.toString();
      // jenisMemberController.text = widget.anggota.jenisMember.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final anggotaProvider =
            Provider.of<AnggotaProvider>(context, listen: false);
        anggotaProvider.loadValues(
            idAnggotaController.text,
            namaAnggotaController.text,
            jenisMemberController.text,
            int.parse(nikController.text),
            int.parse(umurController.text));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final anggotaProvider = Provider.of<AnggotaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Anggota')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: namaAnggotaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Anggota',
                  prefixIcon: Icon(Icons.assignment_ind_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  anggotaProvider.changeNamaAnggota(value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: nikController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NIK Anggota',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => anggotaProvider.changeNik(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: umurController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Umur Anggota',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => anggotaProvider.changeUmur(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: jenisMemberController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Jenis Anggota',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => anggotaProvider.changeJenisMember(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColorLight,
                onPressed: () {
                  anggotaProvider.saveAnggota(check);
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('SAVE')),
              ),
            ),
            (widget.anggota != null)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        anggotaProvider.removeAnggota(widget.anggota.idAnggota);
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
