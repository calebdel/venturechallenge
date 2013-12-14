class LeaguesController < ApplicationController
  
  def index
    @leagues = League.all
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.admin_id = current_user.id
    if @league.save
      redirect_to adminpanel_path
    else
      render :new
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def league_params
    params.require(:league).permit(:name, :school, :start_date, :end_date)
  end


end
