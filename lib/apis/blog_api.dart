import 'dart:convert';

import 'package:blog_admin/apis/auth_api.dart';
import 'package:blog_admin/constants/urls.dart';
import 'package:blog_admin/models/blog_model.dart';
import 'package:blog_admin/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../utils/share_pref.dart';

class BlogApi {
  static Future<bool> storeBlog(BlogModel blogModel) async {
    try {
      String? token = await SharePref.getToken();
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('${baseUrl}admin/blog-news/store'));
      request.body = json.encode(blogModel.toJson());
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('blog store error: $error');
      return false;
    }
  }

  static Future<List<BlogModel>> getBlogList() async {
    try {
      String? token = await SharePref.getToken();
      print('token: $token');
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.Request('GET', Uri.parse('${baseUrl}admin/blog-news'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedJson = await response.stream.bytesToString();
        var decodedJson = jsonDecode(encodedJson);

        List<BlogModel> blogs = List.generate(
          decodedJson['data']['blogs']['data'].length,
          (index) =>
              BlogModel.fromJson(decodedJson['data']['blogs']['data'][index]),
        );

        return blogs;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('get blog list error: $error');
      return [];
    }
  }

  static deleteBlog(num id) async {
    try {
      String? token = await SharePref.getToken();
      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request = http.Request(
          'DELETE', Uri.parse('${baseUrl}admin/blog-news/delete/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('delete blog error: $error');
      return false;
    }
  }

  static updateBlog(num id, BlogModel blogModel) async {
    try {
      print('update api call');
      String? token = await SharePref.getToken();
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('${baseUrl}admin/blog-news/update/$id'));
      request.body = json.encode(blogModel.toJson());
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('update blog error: $error');
      return false;
    }
  }
}
