// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductoCacheModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoCacheModelAdapter extends TypeAdapter<ProductoCacheModel> {
  @override
  final int typeId = 0;

  @override
  ProductoCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductoCacheModel(
      id: fields[0] as int,
      nombre: fields[1] as String,
      precio: fields[2] as String,
      foto: fields[3] as String,
      cantidad: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductoCacheModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.precio)
      ..writeByte(3)
      ..write(obj.foto)
      ..writeByte(4)
      ..write(obj.cantidad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
