class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = current_user.orders.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.new(order_params)
    # @member = current_user.friends.where(id: params[:f.id]).first

    # respond_to do |format|
      if @order.save

        params[:invited_users].each do |u_id|
          @member = current_user.friends.find u_id.to_i
          @order.invited_users << @member
        end
        params[:invited_groups].each do |g_id|
          @group = current_user.groups.find g_id.to_i
          @group.members.each do |group_member|
            begin
              @order.invited_users.find group_member
            rescue
              @order.invited_users << group_member
            end
          end
        end
        respond_to do |format|
          format.json { render json: @order.invited_users }
        end
        # format.html { redirect_to @order, notice: 'Order was successfully created.' }
        # format.json { render :show, status: :created, location: @order }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = current_user.orders.find(params[:id])
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def add_order
    begin
      @member = current_user.friends.where(id: params[:friend_id]).first
      @order = Order.find params[:g.id]
      begin
        @order.invited_users.find @member.id
      rescue
        @order.invited_users << @member
      end
      respond_to do |format|
        # format.html # show.html.erb
        format.json { render json: @member }
      end
    rescue
      respond_to do |format|
        # format.html # show.html.erb
        format.json { render json: "Not found" }
      end
    end


  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_type, :resturant_name, :user_id, :menu_img)
    end
end
