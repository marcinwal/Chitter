
class Peep

  include DataMapper::Resource
  has n, :comments, :through => Resource
  belongs_to :user
  property :id, Serial
  property :text, String

end