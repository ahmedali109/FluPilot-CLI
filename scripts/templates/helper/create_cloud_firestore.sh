#!/bin/bash

function create_cloud_firestore(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/services"
  FIRESTORE_SERVICE_FILE="$DEST_DIR/firestore_service.dart"
  cat <<EOL > "$FIRESTORE_SERVICE_FILE"
import 'package:cloud_firestore/cloud_firestore.dart';

/// A generic Firestore service for CRUD operations on any collection.
class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add a document to a collection. Returns the document ID.
  static Future<String> addDocument(String collection, Map<String, dynamic> data) async {
    final docRef = await _db.collection(collection).add(data);
    return docRef.id;
  }

  /// Get a document by ID from a collection.
  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(String collection, String docId) {
    return _db.collection(collection).doc(docId).get();
  }

  /// Get all documents from a collection.
  static Stream<List<Map<String, dynamic>>> getCollection(String collection) {
    return _db.collection(collection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
  }

  /// Update a document in a collection.
  static Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) {
    return _db.collection(collection).doc(docId).update(data);
  }

  /// Delete a document from a collection.
  static Future<void> deleteDocument(String collection, String docId) {
    return _db.collection(collection).doc(docId).delete();
  }
}

EOL
  echo "📄 Created firestore_service.dart file successfully at $FIRESTORE_SERVICE_FILE"
  echo "✅ Firestore service template generated successfully."
}

export -f create_cloud_firestore
