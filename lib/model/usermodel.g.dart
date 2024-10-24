// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      status: fields[0] as bool?,
      message: fields[1] as String?,
      iD: fields[2] as int?,
      isimsoyisim: fields[3] as String?,
      yetkiGrubu: fields[4] as String?,
      ozelYetkiler: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.iD)
      ..writeByte(3)
      ..write(obj.isimsoyisim)
      ..writeByte(4)
      ..write(obj.yetkiGrubu)
      ..writeByte(5)
      ..write(obj.ozelYetkiler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
