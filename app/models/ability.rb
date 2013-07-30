class Ability < SocialStream::Ability
  #include CanCan::Ability

  def initialize(user)
    super(user)
    can [:read], Closet do |closet|
      closet.actor == user.actor
    end
    can [:edit, :destroy, :update], Closet do |closet|
      closet.actor== user.actor.actor
    end
    can :create, Closet

    can :create, Outfit
    can [:read, :edit, :destroy], Outfit do |outfit|
        arr = user.closets.collect {|x| x.id}
        arr.include? outfit.closet_id
    end

    can [:read,:edit,:destroy,:create], Task do |task|
      task.actor == user.actor
    end
 
  end
end
