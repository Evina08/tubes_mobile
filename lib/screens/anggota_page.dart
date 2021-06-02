import 'package:flutter/material.dart';
import 'package:tubes_flutter/screens/form_anggota.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/models/anggota.dart';

class AnggotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final anggota = Provider.of<List<Anggota>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Anggota'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormAnggota(),
                ),
              );
            },
          )
        ],
      ),
      body: (anggota != null)
          ? ListView.builder(
              itemCount: anggota.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(anggota[index].namaAnggota),
                  trailing: Text(
                    anggota[index].jenisMember,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FormAnggota(
                          anggota[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
