import 'package:tubes_flutter/models/anggota.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/providers/provider_anggota.dart';

class FormAnggota extends StatefulWidget {
  final Anggota anggota;

  FormAnggota([this.anggota]);

  @override
  _FormAnggotaState createState() => _FormAnggotaState();
}

class _FormAnggotaState extends State<FormAnggota> {
  final nikController = TextEditingController();
  final umurController = TextEditingController();
  final namaAnggotaController = TextEditingController();
  final jenisMemberController = TextEditingController();

  @override
  void dispose() {
    nikController.dispose();
    umurController.dispose();
    namaAnggotaController.dispose();
    jenisMemberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.anggota == null) {
      //New Record
      nikController.text = "";
      umurController.text = "";
      namaAnggotaController.text = "";
      jenisMemberController.text = "";
      new Future.delayed(Duration.zero, () {
        final anggotaProvider =
            Provider.of<AnggotaProvider>(context, listen: false);
        anggotaProvider.loadValues(Anggota());
      });
    } else {
      //Controller Update
      nikController.text = widget.anggota.nik.toString();
      umurController.text = widget.anggota.umur.toString();
      namaAnggotaController.text = widget.anggota.namaAnggota.toString();
      jenisMemberController.text = widget.anggota.jenisMember.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final anggotaProvider =
            Provider.of<AnggotaProvider>(context, listen: false);
        anggotaProvider.loadValues(widget.anggota);
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
                controller: nikController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NIK Anggota',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  anggotaProvider.changeNik(value);
                },
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
                onChanged: (value) {
                  anggotaProvider.changeUmur(value);
                },
              ),
            ),
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
                  anggotaProvider.saveAnggota();
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
