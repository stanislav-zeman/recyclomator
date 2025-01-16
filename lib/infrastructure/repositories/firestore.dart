import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recyclomator/infrastructure/utils/firestore_documents.dart';

class FirestoreRepository<T> {
  FirestoreRepository(
    String collectionName, {
    required DocumentDeserializer<T> fromJson,
    required DocumentSerializer<T> toJson,
  }) : _reference = FirebaseFirestore.instance
            .collection(collectionName)
            .withConverter(
              fromFirestore:
                  (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                      deserializeJsonDocument(snapshot, fromJson),
              toFirestore: (value, _) => serializeJsonDocument(value, toJson),
            );

  final CollectionReference<T> _reference;

  /// Creates a new document in collection with random ID
  Future<void> add(T data) async {
    await _reference.add(data);
  }

  /// Deletes a document from collection
  Future<void> delete(String id) async {
    await _reference.doc(id).delete();
  }

  /// Replaces all data of a specific document. If it does not exist, new document (with the specified ID) is created
  Future<void> setOrAdd(String id, T data) async {
    await _reference.doc(id).set(data);
  }

  /// Returns a stream of all documents in the collection
  Stream<List<T>> observeDocuments() {
    return _reference.snapshots().map(_mapQuerySnapshotToData);
  }

  /// Observes a single document in collection with specific ID
  Stream<T?> observeDocument(String id) {
    return _reference
        .doc(id)
        .snapshots()
        .map((DocumentSnapshot<T> documentSnapshot) => documentSnapshot.data());
  }

  /// Observes all documents, whose ID is in the set of [ids].
  Stream<List<T>> observeDocumentsByIds(Set<String> ids) {
    if (ids.isEmpty) {
      return Stream.value(<T>[]);
    }

    return _reference
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map(_mapQuerySnapshotToData);
  }

  /// Returns a list of all documents in collection
  Future<List<T>> getDocuments() async {
    final QuerySnapshot<T> documentsSnapshot = await _reference.get();
    return _mapQuerySnapshotToData(documentsSnapshot);
  }

  /// Returns a single document in collection with specific ID
  Future<T?> getDocument(String id) async {
    final DocumentSnapshot<T> documentData = await _reference.doc(id).get();
    return documentData.data();
  }

  /// Observes all documents, whose ID is in the set of [ids].
  Future<List<T>> getDocumentsByIds(Set<String> ids) async {
    if (ids.isEmpty) {
      return <T>[];
    }

    final QuerySnapshot<T> documentsSnapshot =
        await _reference.where(FieldPath.documentId, whereIn: ids).get();
    return _mapQuerySnapshotToData(documentsSnapshot);
  }

  List<T> _mapQuerySnapshotToData(QuerySnapshot<T> snapshot) {
    return snapshot.docs
        .map(
          (QueryDocumentSnapshot<T> documentSnapshot) =>
              documentSnapshot.data(),
        )
        .toList();
  }
}
