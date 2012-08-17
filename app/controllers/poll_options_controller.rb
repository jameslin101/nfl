class PollOptionsController < ApplicationController

  before_filter :authenticate_user!
  #, :except => [:index, :show, :search]

  def vote_up
    @poll_option = PollOption.find(params[:poll_option_id])
    @poll_option.vote_up(current_user)
    redirect_to poll_path(@poll_option.poll), :notice => "Your vote is successfully submitted"
  end
  
  def unvote
    @poll_option = PollOption.find(params[:poll_option_id])
    @poll_option.unvote(current_user)
    redirect_to poll_path(@poll_option.poll), :notice => "Your unvote is successfully submitted."
  end
end
