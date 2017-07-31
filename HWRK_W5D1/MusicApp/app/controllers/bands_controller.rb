class BandsController < ApplicationController


  def index
    @bands = Band.all
  end

  def show
    @band = Band.find_by(id: params[:id])
  end

  def new
    @band = Band.new
    render :band_form
  end


  def create
    new_band = Band.new(bands_params)
    if new_band.save
      redirect_to band_url(new_band)
    else
      flash[:errors] = new_band.errors.full_messages
      redirect_to new_band_url
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :band_form
  end

  def update
    band =  Band.find_by(id: params[:id])
    if band.save
      redirect_to band_url(new_band)
    else
      flash[:errors] = band.errors.full_messages
      redirect_to edit_band_url
    end
  end

  def destroy
    Band.destroy(params[:id])
  end

  private
  def bands_params
    params.require(:band).permit(:name)
  end
end
