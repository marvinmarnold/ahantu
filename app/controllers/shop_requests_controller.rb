class ShopRequestsController < ApplicationController
  before_action :set_shop_request, only: [:show, :edit, :update, :destroy]

  # GET /shop_requests
  # GET /shop_requests.json
  def index
    @shop_requests = ShopRequest.all
  end

  # GET /shop_requests/1
  # GET /shop_requests/1.json
  def show
  end

  # GET /shop_requests/new
  def new
    @shop_request = ShopRequest.new
  end

  # GET /shop_requests/1/edit
  def edit
  end

  # POST /shop_requests
  # POST /shop_requests.json
  def create
    @shop_request = ShopRequest.new(shop_request_params)

    respond_to do |format|
      if @shop_request.save
        format.html { redirect_to @shop_request, notice: 'Shop request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shop_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @shop_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_requests/1
  # PATCH/PUT /shop_requests/1.json
  def update
    respond_to do |format|
      if @shop_request.update(shop_request_params)
        format.html { redirect_to @shop_request, notice: 'Shop request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shop_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_requests/1
  # DELETE /shop_requests/1.json
  def destroy
    @shop_request.destroy
    respond_to do |format|
      format.html { redirect_to shop_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_request
      @shop_request = ShopRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_request_params
      params.require(:shop_request).permit(:user_id, :state, :request)
    end
end
