import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'trips_record.g.dart';

abstract class TripsRecord implements Built<TripsRecord, TripsRecordBuilder> {
  static Serializer<TripsRecord> get serializer => _$tripsRecordSerializer;

  DocumentReference? get countryRef;

  DocumentReference? get cityRef;

  DocumentReference? get userRef;

  DateTime? get checkInDate;

  DateTime? get checkOutDate;

  String? get hotelName;

  String? get image;

  String? get cityName;

  String? get countryName;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TripsRecordBuilder builder) => builder
    ..hotelName = ''
    ..image = ''
    ..cityName = ''
    ..countryName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Trips');

  static Stream<TripsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TripsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TripsRecord._();
  factory TripsRecord([void Function(TripsRecordBuilder) updates]) =
      _$TripsRecord;

  static TripsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTripsRecordData({
  DocumentReference? countryRef,
  DocumentReference? cityRef,
  DocumentReference? userRef,
  DateTime? checkInDate,
  DateTime? checkOutDate,
  String? hotelName,
  String? image,
  String? cityName,
  String? countryName,
}) {
  final firestoreData = serializers.toFirestore(
    TripsRecord.serializer,
    TripsRecord(
      (t) => t
        ..countryRef = countryRef
        ..cityRef = cityRef
        ..userRef = userRef
        ..checkInDate = checkInDate
        ..checkOutDate = checkOutDate
        ..hotelName = hotelName
        ..image = image
        ..cityName = cityName
        ..countryName = countryName,
    ),
  );

  return firestoreData;
}
