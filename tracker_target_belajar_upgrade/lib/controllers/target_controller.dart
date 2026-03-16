import 'package:get/get.dart';
import '../models/target_model.dart';
import '../services/supabase_service.dart';

class TargetController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  var targets = <TargetModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTargets();
    super.onInit();
  }

  Future<void> fetchTargets() async {
    try {
      isLoading(true);
      final data = await supabaseService.fetchTargets();
      targets.assignAll(data);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addTarget(TargetModel target) async {
    try {
      await supabaseService.insertTarget(target);
      await fetchTargets();
    } catch (e) {
      Get.snackbar("Error", "Gagal menambah data: $e");
    }
  }

  Future<void> editTarget(TargetModel target) async {
    try {
      print("Memulai edit di controller...");
      await supabaseService.updateTarget(target);
      print("Edit sukses, refresh data...");
      await fetchTargets();
      Get.snackbar("Sukses", "Data berhasil diupdate");
    } catch (e) {
      print("Edit gagal: $e");
      Get.snackbar("Error", "Gagal mengupdate: $e");
    }
  }

  Future<void> removeTarget(String id) async {
    try {
      print("Memulai hapus ID: $id");
      await supabaseService.deleteTarget(id);
      print("Hapus sukses, refresh data...");
      await fetchTargets();
      Get.snackbar("Sukses", "Data berhasil dihapus");
    } catch (e) {
      print("Hapus gagal: $e");
      Get.snackbar("Error", "Gagal menghapus: $e");
    }
  }

  void toggleSelesai(TargetModel target) async {
    try {
      print("Toggle selesai - ID: ${target.id}, current: ${target.selesai}");
      final updated = target.copyWith(selesai: !target.selesai);
      print("Updated value: ${updated.selesai}");
      await editTarget(updated);
    } catch (e) {
      print("Toggle error: $e");
      Get.snackbar("Error", "Gagal mengubah status: $e");
    }
  }
}