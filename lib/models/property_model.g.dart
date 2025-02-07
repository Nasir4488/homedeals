// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertyAdapter extends TypeAdapter<Property> {
  @override
  final int typeId = 0;

  @override
  Property read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Property(
      id: fields[0] as String?,
      userId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      type: fields[4] as String,
      price: fields[5] as double,
      currency: fields[6] as String?,
      address: fields[7] as String,
      city: fields[8] as String,
      state: fields[9] as String,
      country: fields[10] as String,
      zipCode: fields[11] as String,
      latitude: fields[12] as double?,
      longitude: fields[13] as double?,
      bedrooms: fields[14] as int,
      bathrooms: fields[15] as int,
      yearBuilt: fields[16] as DateTime?,
      listingAgent: fields[17] as ListingAgent,
      label: fields[18] as String,
      status: fields[19] as String,
      photos: (fields[20] as List?)?.cast<String>(),
      videos: (fields[21] as List?)?.cast<String>(),
      features: (fields[22] as List?)?.cast<String>(),
      area: fields[23] as int?,
      isfeatured: fields[24] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Property obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.currency)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.state)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.zipCode)
      ..writeByte(12)
      ..write(obj.latitude)
      ..writeByte(13)
      ..write(obj.longitude)
      ..writeByte(14)
      ..write(obj.bedrooms)
      ..writeByte(15)
      ..write(obj.bathrooms)
      ..writeByte(16)
      ..write(obj.yearBuilt)
      ..writeByte(17)
      ..write(obj.listingAgent)
      ..writeByte(18)
      ..write(obj.label)
      ..writeByte(19)
      ..write(obj.status)
      ..writeByte(20)
      ..write(obj.photos)
      ..writeByte(21)
      ..write(obj.videos)
      ..writeByte(22)
      ..write(obj.features)
      ..writeByte(23)
      ..write(obj.area)
      ..writeByte(24)
      ..write(obj.isfeatured);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListingAgentAdapter extends TypeAdapter<ListingAgent> {
  @override
  final int typeId = 1;

  @override
  ListingAgent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListingAgent(
      name: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ListingAgent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListingAgentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
