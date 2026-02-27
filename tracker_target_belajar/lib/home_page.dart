import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_page.dart';
import 'folder_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, String>> dataTarget = [];

  String? folderAktif;
  
  void tambahData(Map<String, String> data) {
    setState(() {
      dataTarget.add(data);
    });
  }

  void editData(int index, Map<String, String> dataBaru) {
    setState(() {
      dataTarget[index] = dataBaru;
    });
  }

  void hapusData(int index) {
    setState(() {
      dataTarget.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataFiltered = folderAktif == null
        ? dataTarget
        : dataTarget
            .where((data) => data['kategori'] == folderAktif)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          folderAktif == null
              ? "Semua Target Semester"
              : "Folder: $folderAktif",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder),
            onPressed: () async {
              final hasil = await Get.to(() => FolderPage(
                    dataTarget: dataTarget,
                  ));

              if (hasil != null) {
                setState(() {
                  folderAktif = hasil;
                });
              }
            },
          ),
          if (folderAktif != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  folderAktif = null;
                });
              },
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: dataFiltered.length,
        itemBuilder: (context, index) {
          final item = dataFiltered[index];

          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            color: item['isDone'] == 'true'
                ? Colors.grey[300]
                : Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📂 ${item['kategori']}",
                ),
                
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dataFiltered[index]['isDone'] =
                              dataFiltered[index]['isDone'] == 'true'
                                  ? 'false'
                                  : 'true';
                        });
                      },
                      child: Icon(
                        dataFiltered[index]['isDone'] == 'true'
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: dataFiltered[index]['isDone'] == 'true'
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Mata Kuliah: ${dataFiltered[index]['matkul']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                Text("Target: ${dataFiltered[index]['target']}"),
                Text("Deadline: ${dataFiltered[index]['deadline']}"),
                
                if ((dataFiltered[index]['deskripsi'] ?? "").isNotEmpty)
                  Text(
                    "Deskripsi: ${dataFiltered[index]['deskripsi']}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Get.to(() => FormPage(
                          onSubmit: (dataBaru) {
                            final originalIndex = dataTarget.indexOf(dataFiltered[index]);
                            editData(originalIndex, dataBaru);
                          },
                          dataLama: dataFiltered[index],
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        final originalIndex = dataTarget.indexOf(dataFiltered[index]);
                        hapusData(originalIndex);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => FormPage(
            onSubmit: (data) {
              tambahData(data);
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}