class Rb < NflPlayer
  
  embeds_many :rb_stats

  def stats
    rb_stats
  end
end