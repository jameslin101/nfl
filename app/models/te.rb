class Te < NflPlayer
  
  embeds_many :te_stats

  def stats
    te_stats
  end
end