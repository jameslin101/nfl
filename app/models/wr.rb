class Wr < NflPlayer
  
  embeds_many :wr_stats
  
  def stats
    wr_stats
  end

end