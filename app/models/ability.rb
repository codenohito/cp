class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    # :read, :create, :update, :destroy and :manage
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user.admin?
      can :manage, Nakama
    else
      can :read, Nakama, id: user.nakama_id
    end

    if user.admin?
      can :manage, Project
    else
      can :read, Project
    end

    if user.admin?
      can :manage, Timer
    else
      can :manage, Timer, user_id: user.id
    end

    if user.admin?
      can :manage, TimeRecord
      # includes :change_nakama
      # includes :work_with_expired
    else
      can :read, TimeRecord, nakama_id: user.nakama_id
      can [:create, :update, :destroy], TimeRecord do |time_record|
        time_record.nakama_id == user.nakama_id &&
        time_record.theday > Date.today - 1.week
      end
    end
  end
end
