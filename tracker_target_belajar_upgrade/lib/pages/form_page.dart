import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/target_controller.dart';
import '../models/target_model.dart';

class FormPage extends StatefulWidget {
  final TargetModel? target;

  const FormPage({super.key, this.target});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TargetController targetController = Get.find();

  final kategoriCtrl = TextEditingController();
  final matkulCtrl = TextEditingController();
  final targetCtrl = TextEditingController();
  final deadlineCtrl = TextEditingController();
  final deskripsiCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.target != null) {
      kategoriCtrl.text = widget.target!.kategori;
      matkulCtrl.text = widget.target!.mataKuliah;
      targetCtrl.text = widget.target!.target;
      deadlineCtrl.text =
          DateFormat('yyyy-MM-dd')
              .format(widget.target!.deadline);
      deskripsiCtrl.text =
          widget.target!.deskripsi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.target == null
              ? "Tambah Target"
              : "Edit Target",
        ),

        actions: [
          if (widget.target != null)
            IconButton(
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text(
                      "Hapus Target",
                    ),

                    content: const Text(
                      "Yakin mau hapus target ini?",
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Batal"),
                      ),

                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),

                        onPressed: () async {
                          final id =
                              widget.target!.id;

                          Get.back();
                          await Future.delayed(
                            const Duration(
                                milliseconds: 100),
                          );

                          await targetController
                              .removeTarget(id);

                          Get.until(
                            (route) =>
                                route.isFirst,
                          );
                        },

                        child: const Text(
                          "Hapus",
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Obx(() {
          final folders =
              targetController.targets
                  .map(
                      (e) =>
                          e.kategori)
                  .toSet()
                  .toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<
                    String>(
                  value: folders.contains(
                          kategoriCtrl
                              .text)
                      ? kategoriCtrl
                          .text
                      : null,

                  items:
                      folders.map((f) {
                    return DropdownMenuItem(
                      value: f,
                      child: Text(
                        f.isEmpty
                            ? "Tanpa Folder"
                            : f,
                      ),
                    );
                  }).toList(),

                  onChanged: (v) {

                    kategoriCtrl.text =
                        v ?? '';
                    setState(() {});
                  },

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Pilih Folder",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 8),

                TextField(
                  controller:
                      kategoriCtrl,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Atau ketik folder baru",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 12),
                TextField(
                  controller:
                      matkulCtrl,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Mata Kuliah",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 12),
                TextField(
                  controller:
                      targetCtrl,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Target Belajar",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 12),

                TextField(
                  controller:
                      deadlineCtrl,
                  readOnly: true,

                  onTap: () async {
                    DateTime?
                        picked =
                        await showDatePicker(
                      context:
                          context,
                      initialDate:
                          widget.target
                                  ?.deadline ??
                              DateTime.now(),
                      firstDate:
                          DateTime(2000),
                      lastDate:
                          DateTime(2100),
                    );

                    if (picked !=
                        null) {
                      deadlineCtrl
                          .text = DateFormat(
                              'yyyy-MM-dd')
                          .format(
                              picked);
                    }
                  },

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Deadline",
                    border:
                        OutlineInputBorder(),
                    suffixIcon:
                        Icon(Icons
                            .calendar_today),
                  ),
                ),

                const SizedBox(
                    height: 12),

                TextField(
                  controller:
                      deskripsiCtrl,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Deskripsi",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 20),

                ElevatedButton(
                  style:
                      ElevatedButton
                          .styleFrom(
                    minimumSize:
                        const Size(
                            double.infinity,
                            45),
                  ),

                  onPressed:
                      () async {
                    if (matkulCtrl
                            .text
                            .isEmpty ||
                        targetCtrl
                            .text
                            .isEmpty ||
                        deadlineCtrl
                            .text
                            .isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Matkul, Target, Deadline wajib",
                      );
                      return;
                    }

                    DateTime
                        deadline =
                        DateTime.parse(
                            deadlineCtrl
                                .text);

                    TargetModel
                        newTarget =
                        TargetModel(
                      id: widget
                              .target
                              ?.id ??
                          '',

                      kategori:
                          kategoriCtrl
                              .text,

                      mataKuliah:
                          matkulCtrl
                              .text,

                      target:
                          targetCtrl
                              .text,

                      deadline:
                          deadline,

                      deskripsi:
                          deskripsiCtrl
                              .text,

                      selesai:
                          widget.target
                                  ?.selesai ??
                              false,
                    );

                    if (widget
                            .target ==
                        null) {
                      await targetController
                          .addTarget(
                              newTarget);

                    } else {
                      await targetController
                          .editTarget(
                              newTarget);
                    }
                    Get.until((route) => route.isFirst);
                  },

                  child:
                      const Text(
                    "Simpan",
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}