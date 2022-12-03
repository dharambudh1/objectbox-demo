// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6451117177477533881),
      name: 'Details',
      lastPropertyId: const IdUid(5, 2874323540335485643),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3257211331142173321),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3370576330206822591),
            name: 'firstName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6199339708422910141),
            name: 'lastName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5175620373216036353),
            name: 'gender',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2874323540335485643),
            name: 'age',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 6451117177477533881),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Details: EntityDefinition<Details>(
        model: _entities[0],
        toOneRelations: (Details object) => [],
        toManyRelations: (Details object) => {},
        getId: (Details object) => object.id,
        setId: (Details object, int id) {
          object.id = id;
        },
        objectToFB: (Details object, fb.Builder fbb) {
          final firstNameOffset = fbb.writeString(object.firstName);
          final lastNameOffset = fbb.writeString(object.lastName);
          final genderOffset = fbb.writeString(object.gender);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, firstNameOffset);
          fbb.addOffset(2, lastNameOffset);
          fbb.addOffset(3, genderOffset);
          fbb.addInt64(4, object.age);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Details(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              firstName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              lastName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              gender: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              age: const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Details] entity fields to define ObjectBox queries.
class Details_ {
  /// see [Details.id]
  static final id = QueryIntegerProperty<Details>(_entities[0].properties[0]);

  /// see [Details.firstName]
  static final firstName =
      QueryStringProperty<Details>(_entities[0].properties[1]);

  /// see [Details.lastName]
  static final lastName =
      QueryStringProperty<Details>(_entities[0].properties[2]);

  /// see [Details.gender]
  static final gender =
      QueryStringProperty<Details>(_entities[0].properties[3]);

  /// see [Details.age]
  static final age = QueryIntegerProperty<Details>(_entities[0].properties[4]);
}