class NflPlayersController < ApplicationController
  # GET /nfl_players
  # GET /nfl_players.json
  def index
    @nfl_players = NflPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nfl_players }
    end
  end

  # GET /nfl_players/1
  # GET /nfl_players/1.json
  def show
    @nfl_player = NflPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nfl_player }
    end
  end

  # GET /nfl_players/new
  # GET /nfl_players/new.json
  def new
    @nfl_player = NflPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nfl_player }
    end
  end

  # GET /nfl_players/1/edit
  def edit
    @nfl_player = NflPlayer.find(params[:id])
  end

  # POST /nfl_players
  # POST /nfl_players.json
  def create
    @nfl_player = NflPlayer.new(params[:nfl_player])

    respond_to do |format|
      if @nfl_player.save
        format.html { redirect_to @nfl_player, notice: 'Nfl player was successfully created.' }
        format.json { render json: @nfl_player, status: :created, location: @nfl_player }
      else
        format.html { render action: "new" }
        format.json { render json: @nfl_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nfl_players/1
  # PUT /nfl_players/1.json
  def update
    @nfl_player = NflPlayer.find(params[:id])

    respond_to do |format|
      if @nfl_player.update_attributes(params[:nfl_player])
        format.html { redirect_to @nfl_player, notice: 'Nfl player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nfl_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nfl_players/1
  # DELETE /nfl_players/1.json
  def destroy
    @nfl_player = NflPlayer.find(params[:id])
    @nfl_player.destroy

    respond_to do |format|
      format.html { redirect_to nfl_players_url }
      format.json { head :no_content }
    end
  end
end
