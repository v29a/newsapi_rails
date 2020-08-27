# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin


    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    private
    def access_whitelist
      current_user.role.role_name == "Admin" || "Super Admin" || "Publisher" || "Creator" || "Author" || "Editor"
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
    private
    def is_super_admin
      if current_user.role.role_name == "Super Admin"
        redirect_to admin_root_path
      end            
    end

    def is_admin
      if current_user.role.role_name == "Admin"
        redirect_to admin_root_path
      end            
    end

    def is_publisher
      if current_user.role.role_name == "Publisher"
        redirect_to admin_root_path
      end      
    end

    def is_creator
      if current_user.role.role_name == "Creator"
        redirect_to admin_root_path
      end     
    end

    def is_author
      if current_user.role.role_name == "Author"
        redirect_to admin_root_path
      end
    end

    def is_editor
      if current_user.role.role_name == "Editor"
        redirect_to admin_root_path
      end
    end
  end

end
