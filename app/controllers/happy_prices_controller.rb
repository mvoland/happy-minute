class HappyPricesController < ApplicationController
  before_action :authenticate_owner!, except: [:index]

  def index
    @business
    @happy_prices = HappyPrice.all
  end

  def new
    @business = Business.find(params[:business_id])
    @item = @business.items.find(params[:item_id])
    @happy_price = @item.happy_prices.new
  end

  def create
    @business = Business.find(params[:business_id])
    @item = @business.items.find(params[:item_id])
    @happy_price = @item.happy_prices.new(happy_price_params)
    if @happy_price.save
      redirect_to business_item_path(@business, @item), flash: { success: 'Happy Minute créé' }
    else
      render :new
    end
  end

  def edit
    @business = Business.find(params[:business_id])
    @item = @business.items.find(params[:item_id])
    @happy_price = @item.happy_prices.find(params[:id])
  end

  def update
    @business = Business.find(params[:business_id])
    @item = @business.items.find(params[:item_id])
    @happy_price = @item.happy_prices.find(params[:id])
    if @happy_price.update(happy_price_params)
      redirect_to business_item_path(@business, @item), flash: { success: 'Happy Minute mis à jour' }
    else
      render :edit
    end
  end

  def destroy
    @business = Business.find(params[:business_id])
    @item = @business.items.find(params[:item_id])
    @happy_price = @item.happy_prices.find(params[:id])
    @happy_price.destroy
    redirect_to business_item_path(@business, @item), flash: { success: 'Happy Minute supprimé' }
  end

  private

  def happy_price_params
    params.require(:happy_price).permit(:price, :quantity, :start_date, :end_date)
  end
end
