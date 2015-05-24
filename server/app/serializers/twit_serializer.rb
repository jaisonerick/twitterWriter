class TwitSerializer < ActiveModel::Serializer
  attributes :id, :body, :origin_id, :twit_date
  has_one :author
end
