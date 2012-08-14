class Dp < NflPlayer

  embeds_many :dp_stats
 
  def stats
    dp_stats
  end
end
