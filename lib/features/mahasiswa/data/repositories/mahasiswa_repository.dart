import 'package:arviancb/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final DioClient _dioClient;

  MahasiswaRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dioClient.dio.get('/comments');
      final List data = response.data;
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat data mahasiswa: $e');
    }
  }
}