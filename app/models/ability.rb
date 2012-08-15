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
    # can [:read, :linkedin_contacts, :invite_linkedin, :select_contacts, :invite, :invite_email, :email_contacts, :contacts], User
    # can [:create, :edit, :update, :destroy, :leads, :signin_partner], User do |other|
    #   other == user
    # end

    # can [:create, :edit, :update, :destroy, :trade, :read], Lead do |lead|
    #   lead.holder == user || lead.new_record?
    # end
    # can :trade, Lead do |lead|
    #   lead.holder == user && lead.is_not_forked?
    # end

    # can :read, Lead do |lead|
    #   user.received_lead_trades.map(&:original_lead).include?(lead) ||
    #     user.lead_trades.map(&:recipient_lead).include?(lead)
    # end

    # can :create, Project do |project|
    #   project.new_record? || project.lead.is_not_forked?
    # end
    # can [:edit, :destroy, :update, :invite, :invite_form, :complete, :rate, :review], Project do |project|
    #   project.owner.user == user
    # end
    # can :read, Project do |project|
    #   project.users.include?(user) ||
    #     project.project_invitations.map(&:invitee).include?(user)
    # end

    # can [:read, :create, :destroy, :update], LeadTrade do |lead_trade|
    #   lead_trade.new_record? || (lead_trade.originator == user)
    # end
    # can :accept, LeadTrade do |lead_trade|
    #   lead_trade.recipient == user || (lead_trade.originator == user && lead_trade.recipient_accepted?)
    # end
    # can [:select_lead, :reject, :update], LeadTrade do |lead_trade|
    #   lead_trade.recipient == user
    # end

    # can :manage, ProjectInvitation do |pi|
    #   ProjectInvitation.pending_for_user(user).include?(pi)
    # end

    # # need to refine below abilities
    # can :manage, Task
  end
end
