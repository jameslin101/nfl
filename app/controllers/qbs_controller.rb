class QbsController < ApplicationController
  # GET /qbs
  # GET /qbs.json
  def index
    @qbs = Qb.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qbs }
    end
  end

  # GET /qbs/1
  # GET /qbs/1.json
  def show
    @qb = Qb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qb }
    end
  end

  # GET /qbs/new
  # GET /qbs/new.json
  def new
    @qb = Qb.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qb }
    end
  end

  # GET /qbs/1/edit
  def edit
    @qb = Qb.find(params[:id])
  end

  # POST /qbs
  # POST /qbs.json
  def create
    @qb = Qb.new(params[:qb])

    respond_to do |format|
      if @qb.save
        format.html { redirect_to @qb, notice: 'Qb was successfully created.' }
        format.json { render json: @qb, status: :created, location: @qb }
      else
        format.html { render action: "new" }
        format.json { render json: @qb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qbs/1
  # PUT /qbs/1.json
  def update
    @qb = Qb.find(params[:id])

    respond_to do |format|
      if @qb.update_attributes(params[:qb])
        format.html { redirect_to @qb, notice: 'Qb was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qbs/1
  # DELETE /qbs/1.json
  def destroy
    @qb = Qb.find(params[:id])
    @qb.destroy

    respond_to do |format|
      format.html { redirect_to qbs_url }
      format.json { head :no_content }
    end
  end
end
