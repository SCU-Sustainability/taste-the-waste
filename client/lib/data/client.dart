import 'package:dio/dio.dart';

import 'dart:io';
import 'dart:async';

class Client {
  static final Client _client = new Client._internal();
  static final String _url = 'http://localhost:8080/api/';

  static Client get() {
    return _client;
  }

  static String url() {
    return _url;
  }

  Client._internal();

  Future<Response> ping() async {
    var response = await Dio().get(Client._url);
    return response;
  }

  Future<Response> login(String email, String password) async {
    var response = await Dio().postUri(Uri.parse(Client._url + 'login'), data: {
      'email': email,
      'password': password
    });
    return response;
  }

   Future<Response> register(String name, String password, String email, bool provider) async {
    var response = await Dio().postUri(Uri.parse(Client._url + 'users'), data: {
      'email': email,
      'password': password,
      'name': name,
      'provider': provider
    });
    return response;
  }

  Future<Response> post(String token, String name, String description, File imgFile, List tags) async {
    
    FormData formData = new FormData.from({
      'name': name,
      'description': description,
      'post-image': new UploadFileInfo(imgFile, name),
      'tags': tags
    });
    var response = await Dio().post(_url + 'posts', data: formData, options: Options(
      headers: {
        'x-access-token': token
      }
    ));
    return response;
  }

  Future<Response> getPosts(String token) async {
    var response =  await Dio().get(Client.url() + 'posts', options: Options(
    headers: {
      'x-access-token': token
    }));
    return response;
  }
}