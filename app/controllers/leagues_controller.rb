class LeaguesController < ApplicationController
  
  def index
    @leagues = League.all
  end

  def show
     redirect_to leaderboards_path
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.pin = (params[:pin1]+params[:pin2]+params[:pin3]+params[:pin4]).to_i
    @league.admin_id = current_user.id
    if @league.save
      redirect_to adminpanel_path
    else
      render :new
    end
  end

  def update
     @league = League.find(params[:id])

    if @league.update_attributes(league_params)
      redirect_to league_path(@league)
    else
      render :edit
    end
  end

  def assign_league
    if params[:pin].to_i == League.find(params[:league_id]).pin
    store = Store.find_by_user_id(current_user.id)
    store.league_id = params[:league_id]
    store.change_points({ points: 0, kind: 1 })
    store.save
    redirect_to root_path
    else
    flash[:alert] = "Invalid PIN"
    redirect_to leagues_path
    end  
  end

  def quit_league
    store = Store.find_by_user_id(current_user.id)
    league = League.find(store.league_id)
    store.league_id = nil
    store.save
    flash[:notice] = "#{current_user.name} left #{league.name}"
    redirect_to root_path
  end
  

  def edit
    @league = League.find(params[:id])
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    redirect_to adminpanel_path
  end

  private

  

   
  def league_params
    params.require(:league).permit(:name, :school, :start_date, :end_date, :pin)
  end



end
