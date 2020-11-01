import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../models/scanModel.dart';
import '../services/api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<ScanModel> scanmodel_list;

  Future<List<ScanModel>> fetchProducts() async {
    var result = await _api.getDataCollection();
    scanmodel_list = result.documents
        .map((doc) => ScanModel.fromMap(doc.data, doc.documentID))
        .toList();
    return scanmodel_list;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<ScanModel> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return ScanModel.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(ScanModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(ScanModel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
