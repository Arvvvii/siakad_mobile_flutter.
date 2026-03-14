import 'package:dio/dio.dart';
import '../models/dosen_model.dart';

class DosenRepository {

  final Dio _dio = Dio();

  /// Mengambil daftar dosen dari API
  Future<List<DosenModel>> getDosenList() async {

    try {

      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      final List data = response.data;

      return data
          .map((json) => DosenModel.fromJson(json))
          .toList();

    } catch (e) {

      throw Exception('Gagal memuat data dosen: $e');

    }

  }
}