class Ability
  include CanCan::Ability

  def initialize(user)
    can [:manage], Search
    can :read, Location
    can [:create], ContactForm

    if user.guest?
        can :set_language, Profile
        can :register_as_shop_owner, MemberProfile
    end

    if user.guest? || user.shopper?
        can [:manage], Cart, state: "shopping"
        can [:read], Cart
        can [:show], Shop, published: true
        can [:manage], CreditCard
    elsif user.salesperson?
        can [:sign_up], MemberProfile
        can [:read], Cart
        can [:manage], Shop
        can [:manage], Item
        can [:read, :update], ShopRequest
    elsif user.shop_owner?
        can [:update, :destroy, :read], Shop
        can [:manage], Item
        can [:read], Cart
        can [:create, :read], ShopRequest
    elsif user.admin?
        can [:read], ContactForm
    end

  end
end
