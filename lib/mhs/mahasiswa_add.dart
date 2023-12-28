import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sister/const.dart';
import 'package:http/http.dart' as http;
import 'package:sister/mhs/mahasiswa.dart';

class MahasiswaAdd extends StatefulWidget {
  const MahasiswaAdd({super.key});

  @override
  State<MahasiswaAdd> createState() => _MahasiswaAddState();
}

class _MahasiswaAddState extends State<MahasiswaAdd> {
  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _tglLahir = TextEditingController();

  String nama = "";
  String email = "";
  void clearText() {
    _nama.clear();
    _email.clear();
    _tglLahir.clear();
  }

  void kirim() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MahasiswaList()));
  }

  DateTime tglLahir = DateTime.now();
  Future<void> _pilihTgl(BuildContext context) async {
    final DateTime? kalender = await showDatePicker(
        context: context,
        initialDate: tglLahir,
        firstDate: DateTime(1950),
        lastDate: DateTime(2030));

    if (kalender != null && kalender != tglLahir) {
      setState(() {
        tglLahir = kalender;
      });
    }
  }

  Future<void> insertMahasiswa() async {
    String urlInsert = "http://192.168.56.1:9001/api/v1/mahasiswa";
    final Map<String, dynamic> data = {
      "nama": _nama.text.toString(),
      "email": _email.text.toString(),
      "tglLahir": '${tglLahir.toLocal()}'.split(' ')[0]
    };

    try {
      var response = await http.post(Uri.parse(urlInsert),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        kirim();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Mahasiswa",
          style: TextStyle(
            fontSize: judul,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
            child: TextField(
              controller: _nama,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.purple,
                  labelText: "Nama",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.purple,
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Lahir",
                hintText: "Pilih Tanggal Lahir",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.deepPurple.shade200,
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _pilihTgl(context),
              controller: TextEditingController(
                text: "${tglLahir.toLocal()}".split(" ")[0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  insertMahasiswa();
                  clearText();
                },
                child: Text("Simpan")),
          )
        ],
      ),
    );
  }
}
