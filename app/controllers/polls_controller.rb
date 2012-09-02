class PollsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @polls = Poll.desc(:created_at).page(params[:page]).per(3)
  end

  def my_polls
    @polls = Poll.where(:user => current_user).desc(:created_at)
  end
  
  def my_votes
    if params[:week]
      @week = params[:week].to_i
    else
      #default to get last weeks data
      @week = DateHelper::get_week(Time.now) - 1
    end
    @polls = current_user.polls_voted(@week)
  end
      
  def my_profile
  end
  
  
  def leaderboard
    @users = User.desc(:points)
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def vote
    polls = Poll.excludes(:user => current_user).desc(:created_at).to_a
    while !polls.empty? && @poll.nil? 
      poll = polls.pop
      @poll = poll if poll && !poll.voted?(current_user)
    end
  
    @last_poll = Poll.find(session[:last_poll]) if session[:last_poll]
      
  end

  def new
    @poll = Poll.new
    # if params[:poll][:poll_options_attributes]
    #   raise params[:poll][:poll_option_attributes].to_a.flatten.count({"name"=>""}).inspect
    #   params[:poll][:poll_options_attributes].to_a.flatten.count({"name"=>""}).times {@poll.poll_options.build}
    # end
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
      if params[:poll][:poll_options_attributes]
        params[:poll][:poll_options_attributes].to_a.flatten.count({"name"=>""}).times {@poll.poll_options.build}
      end
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
