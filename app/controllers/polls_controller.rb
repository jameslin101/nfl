class PollsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @polls = Poll.desc(:created_at).page(params[:page]).per(3)
  end

  def my_polls
    @polls = Poll.where(:user => current_user).desc(:created_at)
  end
  
  def my_stats
    poll_options = current_user.poll_options
    @polls = poll_options.map{|i| i.poll}
  end
  
  def leaderboard
    @users = User.desc(:points)
  end

  def show
    @poll = Poll.find(params[:id])

  end

  def new
    @poll = Poll.new
    5.times {@poll.poll_options.build}
  end

  def edit
    @poll = Poll.find(params[:id])
    (5 - @poll.poll_options.count).times {@poll.poll_options.build}
    
  end

  def create
    @poll = Poll.new(params[:poll])
    @poll.user_id = current_user.id

    if @poll.save
      redirect_to polls_path, notice: 'Poll was successfully created.' 
    else
      render action: "new" 
    end
  end

  def update
    @poll = Poll.find(params[:id])

    if @poll.update_attributes(params[:poll])
      redirect_to polls_path, notice: 'Poll was successfully created.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    redirect_to polls_path
  end
  
end
