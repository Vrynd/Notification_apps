import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HttpService {
  final http.Client _client;
  HttpService({http.Client? client}) : _client = client ?? http.Client();

  // Download dan Simpan Gambar Pada Perangkat
  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final bytes = await getByteArrayFromUrl(url);

    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  Future<String> getDataFromUrl(String url) async {
    final response = await _client.get(Uri.parse(url));
    return response.body;
  }

  Future<Uint8List> getByteArrayFromUrl(String url) async {
    final response = await _client.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<String> getBase64FromUrl(String url) async {
    final bytes = await getByteArrayFromUrl(url);
    return base64Encode(bytes);
  }
}
