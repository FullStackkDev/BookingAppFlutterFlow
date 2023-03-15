import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'countries_record.g.dart';

abstract class CountriesRecord
    implements Built<CountriesRecord, CountriesRecordBuilder> {
  static Serializer<CountriesRecord> get serializer =>
      _$countriesRecordSerializer;

  String? get name;

  String? get img;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CountriesRecordBuilder builder) => builder
    ..name = ''
    ..img = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Countries');

  static Stream<CountriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CountriesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  CountriesRecord._();
  factory CountriesRecord([void Function(CountriesRecordBuilder) updates]) =
      _$CountriesRecord;

  static CountriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCountriesRecordData({
  String? name,
  String? img,
}) {
  final firestoreData = serializers.toFirestore(
    CountriesRecord.serializer,
    CountriesRecord(
      (c) => c
        ..name = name
        ..img = img,
    ),
  );

  return firestoreData;
}
