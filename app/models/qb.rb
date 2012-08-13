class Qb < NflPlayer

  embeds_many :qb_stats

 
  def stats
    qb_stats
  end
end
