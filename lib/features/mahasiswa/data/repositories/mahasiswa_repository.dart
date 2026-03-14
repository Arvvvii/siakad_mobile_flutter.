import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {

  final Dio _dio = Dio();

  Future<List<MahasiswaModel>> getMahasiswaList() async {

    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/comments',
    );

    final List data = response.data;

    return data
        .map((json) => MahasiswaModel.fromJson(json))
        .toList();
  }
}