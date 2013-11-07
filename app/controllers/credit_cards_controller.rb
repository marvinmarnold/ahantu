class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]
  authorize_resource
  layout "rightbar", only: [:new]

  # GET /credit_cards
  # GET /credit_cards.json
  def index
    @credit_cards = BillingInformation.all
  end

  # GET /credit_cards/1
  # GET /credit_cards/1.json
  def show
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
  end

  # GET /credit_cards/1/edit
  def edit
  end

  # POST /credit_cards
  # POST /credit_cards.json
  def create
    @credit_card = current_user.credit_cards.build(credit_card_params.merge({ip_address: request.remote_ip}))
    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to checkout_path(current_cart), notice: I18n.t("credit_card.create.notice") }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /credit_cards/1
  # PATCH/PUT /credit_cards/1.json
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to @credit_card, notice: 'Billing information was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /credit_cards/1
  # DELETE /credit_cards/1.json
  def destroy
    @credit_card.destroy
    respond_to do |format|
      format.html { redirect_to credit_cards_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = current_user.credit_cards.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_card_params
      params.require(:credit_card).permit(:name_on_card, :expiration, :type, :number, :cvv, :brand)
    end
end
