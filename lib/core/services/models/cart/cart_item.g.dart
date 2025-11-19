part of 'cart_item.dart';

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 2;

  @override
  CartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemModel(
      id: fields[0] as int,
      cartId: fields[1] as int,
      productId: fields[2] as int,
      productEName: fields[3] as String,
      productArName: fields[4] as String?,
      productImage: fields[5] as String?,
      productStock: fields[6] as int,
      productSalePrice: fields[7] as double,
      productRegularPrice: fields[8] as double,
      weight: fields[9] as double,
      quantity: fields[10] as int,
      addedAt: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cartId)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.productEName)
      ..writeByte(4)
      ..write(obj.productArName)
      ..writeByte(5)
      ..write(obj.productImage)
      ..writeByte(6)
      ..write(obj.productStock)
      ..writeByte(7)
      ..write(obj.productSalePrice)
      ..writeByte(8)
      ..write(obj.productRegularPrice)
      ..writeByte(9)
      ..write(obj.weight)
      ..writeByte(10)
      ..write(obj.quantity)
      ..writeByte(11)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
