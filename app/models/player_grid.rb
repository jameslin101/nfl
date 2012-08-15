class PlayerGrid
  
  include Datagrid
  
  scope do
    NflPlayer
  end
  
  filter(:name, :string)
  filter(:team, :enum, :select => NflPlayer.all.distinct('team'))
  filter(:position, :enum, :select => NflPlayer.all.distinct('position'))
  
  column(:yahoo_id)
  column(:name, :url => proc {|p| Rails.application.routes.url_helpers.nfl_player_path(p)})
  column(:number)
  column(:position)
  column(:team)  
  column(:height)
  column(:weight) 
  column(:age) 
  column(:born)   
  column(:college)
  column(:draft)
end