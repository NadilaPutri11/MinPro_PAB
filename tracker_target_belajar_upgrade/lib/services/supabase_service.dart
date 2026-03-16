import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import '../models/target_model.dart';

class SupabaseService extends GetxService {
  final supabase = Supabase.instance.client;

  Future<List<TargetModel>> fetchTargets() async {
    try {
      print("Fetching from table 'targets'...");
      final response = await supabase.from('targets').select();
      print("Response: $response");
      return (response as List).map((e) => TargetModel.fromMap(e)).toList();
    } catch (e) {
      print(" Supabase error: $e");
      return [];
    }
  }

  Future<void> insertTarget(TargetModel target) async {
    final data = target.toMap()..remove('id');
    try {
      print("Inserting data: $data");
      final response = await supabase.from('targets').insert(data);
      print("Insert response: $response");
    } catch (e) {
      print("Insert error: $e");
      rethrow;
    }
  }

  Future<void> updateTarget(TargetModel target) async {
    try {
      print("UPDATE - ID: ${target.id}");

      final data = target.toMap()..remove('id');
      print("Data update: $data");
      
      final response = await supabase
          .from('targets')
          .update(data)
          .eq('id', target.id.toString());
      
      print("Update response: $response");
        } catch (e) {
          print("Update error: $e");
          rethrow;
        }
      }

  Future<void> deleteTarget(String id) async {
    try {
      print("DELETE - Target ID: $id");
      
      final response = await supabase.from('targets').delete().eq('id', id.toString());
      
      print("Delete response: $response");
    } catch (e) {
      print("Delete error: $e");
      rethrow;
    }
  }
}