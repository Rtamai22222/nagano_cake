class Admin::OrdersController < ApplicationController

  # before_action :check_statsu, only[:show]

  def one_person
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = 0
    if @order.status == "payment_pending"
      @making_status_class = true
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(status_params)
      if @order.status == "payment_confirmed"
        order_detail_making_status = @order.order_details
        order_detail_making_status.each do |order_detail|
          if order_detail.making_status == "not_producible"
            order_detail.update(making_status: "waiting_production" )
          end
        end
      end
      redirect_to admin_order_path(params[:id])
    else
      render :show
    end
  end

  private

  # def check_statsu

  # end

  def status_params
    params.require(:order).permit(:status)
  end

end
