class Comment

  include DataMapper::Resource

  propert :id, Serial
  property :comment, Text

end