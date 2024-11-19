// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ClienteCacheModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClienteCacheModelAdapter extends TypeAdapter<ClienteCacheModel> {
  @override
  final int typeId = 2;

  @override
  ClienteCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClienteCacheModel(
      id: fields[0] as int?,
      email: fields[1] as String,
      phone: fields[2] as String,
      name: fields[3] as String,
      paterno: fields[4] as String,
      materno: fields[5] as String,
      tdocumento: fields[6] as String,
      direccion: fields[7] as String,
      postal: fields[8] as String,
      tdatos: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClienteCacheModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.paterno)
      ..writeByte(5)
      ..write(obj.materno)
      ..writeByte(6)
      ..write(obj.tdocumento)
      ..writeByte(7)
      ..write(obj.direccion)
      ..writeByte(8)
      ..write(obj.postal)
      ..writeByte(9)
      ..write(obj.tdatos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClienteCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
