import 'package:dio/dio.dart';

class VisitorService {
  final dio = Dio();
  final baseURL =
      'https://colin-hanbury-showcase-server-511903749491.australia-southeast2.run.app';

  Future<dynamic> getVisitor(String name) async {
    Response response = await dio.get('$baseURL/visitors?$name');
    return response.data;
  }

  Future<dynamic> getVisitors() async {
    Response response = await dio.get('$baseURL/visitors');
    return response.data;
    // return [
    //   {
    //     "_id": "66ee914abec3eec945217ba5",
    //     "name": "Colin Hanbury;",
    //     "date": "2024-09-21T09:26:34.178Z"
    //   },
    //   {
    //     "_id": "66eef1b4d23c67dc2177d281",
    //     "name": "Erin McInerney;",
    //     "date": "2024-09-21T16:17:56.195Z"
    //   }
    // ];
  }

  Future<dynamic> addVisitor(String name) async {
    Response response =
        await dio.post('$baseURL/visitors', data: {'name': name});
    return response;
  }
}
