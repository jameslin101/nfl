class PollsController < ApplicationController

  def index
    @polls = Poll.all
  end

  def show
    @poll = Poll.find(params[:id])

  end

  def new
    @poll = Poll.new
    2.times {@poll.poll_options.build}
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def create
    @poll = Poll.new(params[:poll])

    if @poll.save
      raise @poll.poll_options.inspect
      redirect_to polls_path, notice: 'Poll was successfully created.' 
    else
      render action: "new" 
    end
  end

  def update
    @poll = Poll.find(params[:id])

    if @poll.update_attributes(params[:poll])
      redirect_to @poll, notice: 'Poll was successfully created.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    redirect_to polls_url
  end
  
end
