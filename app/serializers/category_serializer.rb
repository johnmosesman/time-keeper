class CategorySerializer < ActiveModel::Serializer
  embed :ids, embed_in_root: true

  attributes :id, :title, :amount

  has_many :records

  def records
    object.record_for_today
  end
end
