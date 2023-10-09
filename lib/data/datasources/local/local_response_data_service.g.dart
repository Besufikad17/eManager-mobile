// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_response_data_service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalResponseDataAdapter extends TypeAdapter<LocalResponseData> {
  @override
  final int typeId = 0;

  @override
  LocalResponseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalResponseData(
      fields[1] as LocalUser,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalResponseData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalResponseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
