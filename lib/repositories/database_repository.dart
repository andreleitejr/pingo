import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/models/database.dart';
import 'package:pingo/repositories/storage_repository.dart';
import 'package:rxdart/subjects.dart';

abstract class DataBaseRepository<T extends DataBase> {
  DataBaseRepository({
    required this.fromMap,
    required this.name,
  });

  StorageRepository get storageRepository => StorageRepository(name: name);

  final String name;
  final T Function(DocumentSnapshot document) fromMap;

  CollectionReference get collection =>
      FirebaseFirestore.instance.collection(name);

  Reference get storage => FirebaseStorage.instance.ref().child(name);

  Query<Map<String, dynamic>> get collectionGroup =>
      FirebaseFirestore.instance.collectionGroup(name.pathReference);

  final _streamController = BehaviorSubject<List<T>?>();

  List<T>? get result => _streamController.value;

  Stream<List<T>?> get stream => _streamController.stream;

  Future<void> save(T model, {String? documentId}) async {
    try {
      model.createdAt = DateTime.now();
      await collection.doc(documentId).set(model.toMap());
    } catch (e) {
      debugPrint('Data Base Repository | Save Error: $e');
    }
  }

  Future<void> update(String documentId, T model) async {
    try {
      model.updatedAt = DateTime.now();
      await collection.doc(documentId).update(model.toMap());
    } catch (e) {
      debugPrint('Data Base Repository | Update Error: $e');
    }
  }

  Future<void> delete(String documentId) async {
    try {
      await collection.doc(documentId).delete();
    } catch (e) {
      debugPrint('Data Base Repository | Delete Error: $e');
    }
  }

  Stream<List<T>> get read => collectionGroup.snapshots().map(
      (query) => query.docs.map<T>((document) => fromMap(document)).toList());

  Future<T?> get(String documentId) async =>
      await collection.doc(documentId).get().then((doc) => fromMap(doc));

  Future upload(File image) async => await storageRepository.upload(image);

  Future<String?> download(String fileName) async =>
      storageRepository.download(fileName);
}
