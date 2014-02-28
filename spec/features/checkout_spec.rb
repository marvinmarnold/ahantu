describe "the checkout process" do
  # before :each do
  #   User.make(:email => 'user@example.com', :password => 'caplin')
  # end

  background do

  end

  #https://docs.spreedly.com/test-data
  it "allows user to checkout with valid credit card", focus: true do
    credit_card_number = 4111111111111111
    # [
    #   4111111111111111,
    #   4012888888881881,
    #   5555555555554444,
    #   5105105105105100,
    #   378282246310005,
    #   371449635398431,
    #   6011111111111117,
    #   6011000990139424
    # ].each do |credit_card_number|
      visit '/sessions/new'
      within("#session") do
        fill_in 'credit_card_full_name', :with => 'John H. Doe'
        fill_in 'credit_card_number', :with => credit_card_number
        fill_in 'credit_card_verification_value', :with => '123'
        fill_in 'credit_card_month', :with => '1'
        fill_in 'credit_card_year', :with => '18'
      end
      click_link 'Add card'
      expect(page).to have_content 'Success'
    # end

  end
end