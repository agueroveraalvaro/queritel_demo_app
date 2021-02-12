import 'package:dio/dio.dart';

Future<Response> getItems() async {
  try {
    Response response = await Dio().get("https://api.queritel.com/api/test-lab/demo/item_list.php?key=AdhjyGTrsLoibtqBglfGewEw");
    return response;
  } catch (e) {
    print(e);
  }
  return null;
}