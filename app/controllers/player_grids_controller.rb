class PlayerGridsController < ApplicationController
  require 'will_paginate/array'

  def index
    @player_grid = PlayerGrid.new(params[:player_grid])
    @assets = @player_grid.assets.paginate(:page => params[:page])
    
  end
end
