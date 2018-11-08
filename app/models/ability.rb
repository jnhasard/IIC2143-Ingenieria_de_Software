class Ability
	include CanCan::Ability
	def initialize(user)
		user ||= User.new
		if user.tipo >= 3
			can :manage, :all
		else
			can :manage, Comment, user_id: user.id
			can :update, Publication, user_id: user.id
			can :delete, Publication, user_id: user.id
			can :read, :all
		end
	end
end