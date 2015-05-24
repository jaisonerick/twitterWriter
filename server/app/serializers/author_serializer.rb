class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :screen_name, :twitter_id
end
