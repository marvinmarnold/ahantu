class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:destroy]
  authorize_resource
  layout "rightbar", only: [:new]


  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
  end

  # DELETE /credit_cards/1
  # DELETE /credit_cards/1.json
  def destroy
    @credit_card.destroy
    respond_to do |format|
      format.html { redirect_to credit_cards_url }
    end
  end

  def added
    token = params[:token]
    @credit_card = SPREEDLY_ENVIRONMENT.find_payment_method(token)
    # binding.pry
    if @credit_card.valid? && @credit_card = CreditCard.create_from_spreedly_card(@credit_card, token, current_user)
      redirect_to checkout_path(current_cart), notice: t("credit_card.create.notice")
    else
      render action: 'new'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credit_card
    @credit_card = current_user.credit_cards.find(params[:id])
  end

end