# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role
    when 'professor'
      can :manage, EventPlace
      can :manage, User
      can :manage, Reservation
      can :manage, ActiveAdmin::Comments
      can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    when 'student'
      can :update, User, id: user.id
      can :read, Reservation, reserved_by: user
      can :update, Reservation, reserved_by: user, status: "accepted"
      can :create, Reservation, reserved_by: user
    else
      raise "Unknown #{user.role} role!"
    end
  end
end