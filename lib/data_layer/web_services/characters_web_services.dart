import '../../constants/strings.dart';
import 'package:dio/dio.dart';

class charactersWebServices {
  static late Dio dio;

  static CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacter() async {
    try {
      Response response = await dio.get('characters');
      print('==========web services========');
      print(response.data.toString());
      print('==========web services========');
      return response.data;
    } catch (error) {
      print('=======error======');
      print(error.toString());
      print('=============');
      return [];
    }
  }

  Future<List<dynamic>> getQoutes(String nameActor) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': nameActor});
      print('==========qoutes services========');
      print(response.data.toString());
      print('==========qoutes services========');
      return response.data;
    } catch (error) {
      print('=======qoutes    error======');
      print(error.toString());
      print('======qoutes qoutes qoutesqoutesqoutes=======');
      return [];
    }
  }
}
