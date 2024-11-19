// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EntregaCacheModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntregaCacheModelAdapter extends TypeAdapter<EntregaCacheModel> {
  @override
  final int typeId = 3;

  @override
  EntregaCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntregaCacheModel(
      id: fields[0] as int?,
      departamento: fields[1] as String,
      provincia: fields[2] as String,
      distrito: fields[3] as String,
      referencia: fields[4] as String,
      authUserId: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, EntregaCacheModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.departamento)
      ..writeByte(2)
      ..write(obj.provincia)
      ..writeByte(3)
      ..write(obj.distrito)
      ..writeByte(4)
      ..write(obj.referencia)
      ..writeByte(5)
      ..write(obj.authUserId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntregaCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
