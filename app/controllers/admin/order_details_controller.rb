class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_details = OrderDetail.where(order_id: order_detail.order_id)
    if order_detail.update(making_status_params)
      if order_detail.making_status == "in_production"
        order_detail.order.update(status: "making")
      end
      if order_details.all? { |od| od.making_status == 'production_completed' }
        order = order_detail.order
        order.update(status: "preparing_shipment" )
      end
      redirect_to admin_order_path(params[:order_detail][:page_id])
    else
      # @order = Order.find(params[:id])
      # @order_details = OrderDetail.where(order_id: params[:id])
      # render :show
    end
  end

  private

  def making_status_params
    params.require(:order_detail).permit(:making_status)
  end
end
