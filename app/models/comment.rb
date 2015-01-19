class Comment

  include DataMapper::Resource

  belongs_to :peep
  belongs_to :user
  

  property :id, Serial
  property :comment, Text

end