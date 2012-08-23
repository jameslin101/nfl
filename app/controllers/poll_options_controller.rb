class PollOptionsController < ApplicationController

  before_filter :authenticate_user!
  #, :except => [:index, :show, :search]

  def show
    @poll_option = PollOption.find(params[:poll_option_id])
  end
  
  def vote_up
    
    @poll_option = PollOption.find(params[:poll_option_id])
    
    if @poll_option.vote_up(current_user)  
      @can_vote = @poll_option.can_vote?(current_user)  
      respond_to do |format|
        format.html { redirect_to poll_path(@poll_option.poll), :notice => "Your vote is successfully submitted" }
        format.js
      end
    end
  end
  
  def unvote
    @poll_option = PollOption.find(params[:poll_option_id])

    if @poll_option.unvote(current_user)
      @can_vote = @poll_option.can_vote?(current_user)
      respond_to do |format|
        format.html { redirect_to poll_path(@poll_option.poll), :notice => "Your unvote is successfully submitted."}
        format.js
      end
    end
  end

end
