module Tangible
  #Needs body, color
  include Constants
  
  ##Behaviour
  def collides?(entity)
    body.collides?(entity.body)
  end
end