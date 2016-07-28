class Stamp
  attr_accessor :tag, :object

  def initialize(tag, object = nil)
    @tag = tag
    @object = object
  end
end