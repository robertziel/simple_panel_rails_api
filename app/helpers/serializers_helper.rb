module SerializersHelper
  def serialize(object, serializer:, **keys)
    serializer.new(object, **keys).as_json
  end

  def serialize_collection(collection, serializer:, **keys)
    ActiveModel::Serializer::CollectionSerializer.new(
      collection,
      serializer: serializer,
      **keys
    ).as_json
  end
end
