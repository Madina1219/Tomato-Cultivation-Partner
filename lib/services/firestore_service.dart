import 'package:cloud_firestore/cloud_firestore.dart';

/// FirestoreService is the single place where the app reads from and writes
/// to Cloud Firestore. Centralising Firestore access here keeps the UI code
/// clean and makes the data schema explicit and easy to evolve.
///
/// Schema:
///   /users/{uid}/plants/{plantId}    - user's tomato plants
///   /users/{uid}/scans/{scanId}      - AI scan diagnoses
///   /users/{uid}/tasks/{taskId}      - daily care tasks
///   /users/{uid}/rewards/balance     - single doc with points/tier
///   /public/varieties/{varietyId}    - shared variety catalogue (read-only)
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String uid;

  FirestoreService({required this.uid});

  // ---------- Plants ----------

  /// A reference to the user's plants subcollection.
  CollectionReference<Map<String, dynamic>> get _plantsRef =>
      _db.collection('users').doc(uid).collection('plants');

  /// Saves a new plant or overwrites an existing one identified by [plantId].
  /// If [plantId] is null, Firestore generates one.
  Future<String> savePlant({
    String? plantId,
    required String variety,
    required String stage,
    required int dayCount,
    Map<String, dynamic> extras = const {},
  }) async {
    final docRef = plantId == null ? _plantsRef.doc() : _plantsRef.doc(plantId);
    await docRef.set({
      'variety': variety,
      'stage': stage,
      'dayCount': dayCount,
      'updatedAt': FieldValue.serverTimestamp(),
      ...extras,
    }, SetOptions(merge: true));
    return docRef.id;
  }

  /// Live-updating stream of the user's plants, ordered by most-recent first.
  Stream<List<Map<String, dynamic>>> watchPlants() {
    return _plantsRef
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              data['id'] = d.id;
              return data;
            }).toList());
  }

  /// Removes a plant from the user's garden.
  Future<void> deletePlant(String plantId) => _plantsRef.doc(plantId).delete();
}