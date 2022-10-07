import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/core/extensions.dart';
import 'package:pingo/models/database.dart';
import 'package:rxdart/subjects.dart';

abstract class DataBaseRepository<T extends DataBase> {
  DataBaseRepository({
    required this.fromMap,
    required this.name,
  });

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
      await collection.doc(documentId).set(model.toMap());
    } catch (e) {
      // IMPLEMENTAR CRASHLYTICS
      print(e);
    }
  }

  void update(String documentId, T model) =>
      collection.doc(documentId).update(model.toMap());

  void delete(String documentId) => collection.doc(documentId).delete();

  Stream<List<T>> get read => collectionGroup.snapshots().map(
      (query) => query.docs.map<T>((document) => fromMap(document)).toList());

  Future<T?> get(String documentId) async =>
      await collection.doc(documentId).get().then((doc) => fromMap(doc));

  Future<UploadTask?> upload(XFile? file, String fileName) async {
    if (file == null) {
      return null;
    }

    UploadTask uploadTask;

    Reference ref = storage.child(fileName.pathName);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  Future<String> downloadLink(Reference ref) async =>
      await storage.getDownloadURL();
}
