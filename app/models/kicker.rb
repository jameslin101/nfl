class Kicker < NflPlayer

  embeds_many :kicker_stats
 
  def stats
    kicker_stats
  end
end
