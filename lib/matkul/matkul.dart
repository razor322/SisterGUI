import 'dart:convert';
//gybran nauval yuhandika 2111081006
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sister/const.dart';
import 'package:sister/matkul/matkul_add.dart';
import 'package:http/http.dart' as http;
import 'package:sister/matkul/matkul_update.dart';

class MatkulList extends StatefulWidget {
  const MatkulList({super.key});

  @override
  State<MatkulList> createState() => _MatkulListState();
}

class _MatkulListState extends State<MatkulList> {
  List listMatkul = [];
  // Map<String, dynamic> listMatkul = [];

  @override
  void initState() {
    getAllMatkul();
    super.initState();
  }

  Future<void> getAllMatkul() async {
    String urlMahasiswa = "$url_matkul/matkul";
    try {
      var response = await http.get(Uri.parse(urlMahasiswa));
      listMatkul = jsonDecode(response.body);
      setState(() {
        listMatkul = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deteleMatkul(int id) async {
    String urlMahasiswa = "$url_matkul/matkul/${id}";
    try {
      await http.delete(Uri.parse(urlMahasiswa));
      setState(() {
        getAllMatkul();
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MatkulAdd()));
        },
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Data Mata Kuliah",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: listMatkul.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.deepPurple.shade50,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.blue.shade500,
                  size: 24,
                ),
                title: Text(
                  listMatkul[index]["nama"]?.toString() ?? "",
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Kode : ${listMatkul[index]["kode"]!} \n SKS : ${listMatkul[index]["sks"]!}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        tooltip: "Hapus Data",
                        onPressed: () {
                          deteleMatkul(listMatkul[index]["id"]);
                        },
                        icon: Icon(
                          CupertinoIcons.delete_right,
                          color: Colors.red.shade300,
                          size: 24,
                        )),
                    IconButton(
                        tooltip: "Edit Data",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return MatkulUpdate(
                                idup: listMatkul[index]["id"],
                                namaup: listMatkul[index]["nama"],
                                kodeup: listMatkul[index]["kode"],
                                sksup: listMatkul[index]["sks"].toString(),
                              );
                            }),
                          ).then((value) => getAllMatkul());
                        },
                        icon: Icon(
                          CupertinoIcons.pencil,
                          color: Colors.yellow.shade800,
                          size: 30,
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
