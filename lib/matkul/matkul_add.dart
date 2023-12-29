import 'dart:convert';
//gybran nauval yuhandika 2111081006
import 'package:flutter/material.dart';
import 'package:sister/const.dart';
import 'package:sister/matkul/matkul.dart';
import 'package:http/http.dart' as http;

class MatkulAdd extends StatefulWidget {
  const MatkulAdd({super.key});

  @override
  State<MatkulAdd> createState() => _MatkulAddState();
}

class _MatkulAddState extends State<MatkulAdd> {
  final _kode = TextEditingController();
  final _nama = TextEditingController();
  final _sks = TextEditingController();

  void clearText() {
    _nama.clear();
    _kode.clear();
    _sks.clear();
  }

  void kirim() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MatkulList()));
  }

  Future<void> addMatkul() async {
    String urlInsert = "$url_matkul/matkul";
    final Map<String, dynamic> data = {
      "nama": _nama.text.toString(),
      "kode": _kode.text.toString(),
      "sks": int.parse(_sks.text)
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
                  suffixIcon: const Icon(
                    Icons.book,
                    color: Colors.purple,
                  ),
                  focusColor: Colors.purple,
                  labelText: "Nama Mata Kuliah",
                  hintText: "Masukkan nama mata kuliah",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: _kode,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: const Icon(
                    Icons.category_rounded,
                    color: Colors.purple,
                  ),
                  focusColor: Colors.purple,
                  labelText: "Kode Mata Kuliah",
                  hintText: "Masukkan Kode mata kuliah",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              controller: _sks,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.purple,
                  hintText: "Masukkan Jumlah SKS",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  labelText: "Jumlah SKS",
                  suffixIcon: const Icon(
                    Icons.numbers_rounded,
                    color: Colors.purple,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  addMatkul();
                  clearText();
                },
                child: const Text("Simpan")),
          )
        ],
      ),
    );
  }
}
