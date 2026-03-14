import 'package:dio/dio.dart';
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {

  final Dio _dio = Dio();

  Future<List<MahasiswaAktifModel>> getMahasiswaAktif() async {

    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );

    final List data = response.data;

    return data
        .map((json) => MahasiswaAktifModel.fromJson(json))
        .toList();
  }
}