// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberModelAdapter extends TypeAdapter<MemberModel> {
  @override
  final int typeId = 1;

  @override
  MemberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberModel(
      documentId: fields[0] as String?,
      memberName: fields[1] as String?,
      emailAddress: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      address: fields[4] as String?,
      gender: fields[5] as String?,
      lastModified: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MemberModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.documentId)
      ..writeByte(1)
      ..write(obj.memberName)
      ..writeByte(2)
      ..write(obj.emailAddress)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
