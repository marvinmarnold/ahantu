class BillingInformationsController < ApplicationController
  before_action :set_billing_information, only: [:show, :edit, :update, :destroy]

  # GET /billing_informations
  # GET /billing_informations.json
  def index
    @billing_informations = BillingInformation.all
  end

  # GET /billing_informations/1
  # GET /billing_informations/1.json
  def show
  end

  # GET /billing_informations/new
  def new
    @billing_information = BillingInformation.new
  end

  # GET /billing_informations/1/edit
  def edit
  end

  # POST /billing_informations
  # POST /billing_informations.json
  def create
    @billing_information = BillingInformation.new(billing_information_params)

    respond_to do |format|
      if @billing_information.save
        format.html { redirect_to @billing_information, notice: 'Billing information was successfully created.' }
        format.json { render action: 'show', status: :created, location: @billing_information }
      else
        format.html { render action: 'new' }
        format.json { render json: @billing_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /billing_informations/1
  # PATCH/PUT /billing_informations/1.json
  def update
    respond_to do |format|
      if @billing_information.update(billing_information_params)
        format.html { redirect_to @billing_information, notice: 'Billing information was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @billing_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /billing_informations/1
  # DELETE /billing_informations/1.json
  def destroy
    @billing_information.destroy
    respond_to do |format|
      format.html { redirect_to billing_informations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing_information
      @billing_information = BillingInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def billing_information_params
      params.require(:billing_information).permit(:first_name, :last_name, :expiration, :type)
    end
end
