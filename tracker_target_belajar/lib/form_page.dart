import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPage extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;
  final Map<String, String>? dataLama;

  const FormPage({
    super.key,
    required this.onSubmit,
    this.dataLama,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController matkulController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.dataLama != null) {
      kategoriController.text = widget.dataLama?['kategori'] ?? "";
      matkulController.text = widget.dataLama!['matkul']!;
      targetController.text = widget.dataLama!['target']!;
      deadlineController.text = widget.dataLama!['deadline']!;
      deskripsiController.text = widget.dataLama?['deskripsi'] ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Target"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // BEST PRACTICE kembali
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: kategoriController,
              decoration: const InputDecoration(
                labelText: "Kategori / Folder",
              ),
            ),

            TextField(
              controller: matkulController,
              decoration: InputDecoration(
                labelText: "Mata Kuliah",
              ),
            ),

            TextField(
              controller: targetController,
              decoration: InputDecoration(
                labelText: "Target Belajar",
              ),
            ),

            TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: "Deadline",
              ),
            ),

            TextField(
              controller: deskripsiController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Deskripsi (Opsional)",
                hintText: "Tambahkan detail jika diperlukan",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
            onPressed: () {

              if (matkulController.text.isEmpty ||
                  targetController.text.isEmpty ||
                  deadlineController.text.isEmpty) {

                Get.snackbar(
                  "Error",
                  "Mata Kuliah, Target, dan Deadline tidak boleh kosong",
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }

              Map<String, String> data = {
                'kategori': kategoriController.text,
                'matkul': matkulController.text,
                'target': targetController.text,
                'deadline': deadlineController.text,
                'deskripsi': deskripsiController.text,
                'isDone': widget.dataLama?['isDone'] ?? 'false',
              };

              widget.onSubmit(data);
              Get.back();
            },
            child: const Text("Simpan"),
            )

          ],
        ),
      ),
    );
  }
}