class QbStat < Stat

  embeds_one :passing, autobuild: true
  embeds_one :rushing, as: :rushable, autobuild: true
  embeds_one :sacks, as: :sackable, autobuild: true
  embeds_one :fumbles, as: :fumbleable, autobuild: true
  
end