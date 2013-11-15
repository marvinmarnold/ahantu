class ShopRequestsController < ApplicationController
  before_action :set_shop_request, only: [:show, :edit, :update, :destroy]
  authorize_resource


  # GET /shop_requests
  # GET /shop_requests.json
  def index
    return redirect_to shops_path
  end

  # GET /shop_requests/1
  # GET /shop_requests/1.json
  def show
    return redirect_to shop_requests_path
  end

  # GET /shop_requests/new
  def new
    @shop_request = ShopRequest.new
  end

  # GET /shop_requests/1/edit
  def edit
    return redirect_to new_shop_request_path
  end

  # POST /shop_requests
  # POST /shop_requests.json
  def create
    @shop_request = current_user.profile.shop_requests.build shop_request_params

    respond_to do |format|
      if @shop_request.save
        format.html { redirect_to @shop_request, notice: 'Shop request was successfully created.' }
        format.json { render action: 'index', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @shop_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_requests/1
  # PATCH/PUT /shop_requests/1.json
  def update
    return redirect_to new_shop_request_path
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
      @shop_request = current_user.shop_requests.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_request_params
      params.require(:shop_request).permit(:shop_name, :location_id, :state, :request)
    end
end
