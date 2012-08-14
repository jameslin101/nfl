class Punter < NflPlayer

  embeds_many :punter_stats

  def stats
    punter_stats
  end 
end
