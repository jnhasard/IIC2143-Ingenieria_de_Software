module PermissionsConcern
	extend ActiveSupport::Concern
	def is_comun_user?
    	self.tipo >= 1
  	end
  	def is_mod_user?
    	self.tipo >= 2
  	end
  	def is_admin_user?
    	self.tipo >= 3
  	end
end
