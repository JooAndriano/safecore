// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicalEmergencyAdapter extends TypeAdapter<MedicalEmergency> {
  @override
  final int typeId = 1;

  @override
  MedicalEmergency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicalEmergency(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      assetPath: fields[3] as String,
      icon: fields[4] as String,
      symptoms: (fields[5] as List).cast<String>(),
      firstAid: (fields[6] as List).cast<String>(),
      createdAt: fields[7] as DateTime?,
      updatedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalEmergency obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.assetPath)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.symptoms)
      ..writeByte(6)
      ..write(obj.firstAid)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalEmergencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
