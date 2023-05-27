class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Inventory, public: true

    can :manage, Recipe, user: user

    return unless user.present?

    can :manage, :all, user: user
  end
end
