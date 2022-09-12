import 'package:cloud_firestore/cloud_firestore.dart';
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

  Query<Map<String, dynamic>> get collectionGroup =>
      FirebaseFirestore.instance.collectionGroup(name.pathReference);

  final _streamController = BehaviorSubject<List<T>?>();

  List<T>? get result => _streamController.value;

  Stream<List<T>?> get stream => _streamController.stream;

  Future<void> save(T model) async => await collection.add(model.toMap());

  void update(String documentId, T model) =>
      collection.doc(documentId).update(model.toMap());

  void delete(String documentId) => collection.doc(documentId).delete();

  Stream<List<T>> get read => collectionGroup.snapshots().map(
        (query) => query.docs.map<T>((document) => fromMap(document)).toList(),
      );
}
