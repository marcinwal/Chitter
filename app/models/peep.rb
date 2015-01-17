
class Peep

  include DataMapper::Resource

  has n, :comments, :through => Resource

  property :id, Serial
  property :text, String
  belongs_to :user


end