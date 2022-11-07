class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_purchase, only: %i[show edit update destroy]

  def index
    get_data_for_this_user
    if params[:category_name].present?
      filter_by_category_name
    elsif params[:buy_at].present?
      filter_by_buy_at
    else
      @purchases = @user_purchases
    end
    @total_cost = @purchases.sum(:price)
  end

  def show; end

  def new
    @purchase = Purchase.new(user: current_user)
  end

  def edit; end

  def create
    @purchase = current_user.purchases.build(filtered_params)
    if @purchase.valid?
      @purchase.save
      flash[:messages] = 'Successfully created'
      redirect_to purchases_path
    else
      flash[:notice] = @purchase.errors.full_messages
      redirect_to new_purchase_path
    end
  end

  def update
    if @purchase.update(filtered_params)
      redirect_to purchases_path
    else
      render :edit
    end
  end

  def destroy
    @purchase.destroy
    redirect_to purchases_path
  end

  def remove_all
    Purchase.delete_all
    flash[:notice] = 'You have removed all results!'
    redirect_to purchases_path
  end

  def filter_by_buy_at
    @purchases = @user_purchases.where(buy_at: params[:buy_at])
  end

  def filter_by_category_name
    @purchases = @user_purchases.where(category_name: params[:category_name])
  end

  private

  def filtered_params
    params.require(:purchase).permit(:category_name, :user_id, :price, :buy_at, :description)
  end

  def get_purchase
    @purchase = Purchase.find(params[:id])
  end

  def get_data_for_this_user
    @user_purchases = current_user.purchases
    @date_list = ['all'] + @user_purchases.distinct.pluck(:buy_at)
    @category_list = ['all'] + @user_purchases.distinct.pluck(:category_name)
  end
end
