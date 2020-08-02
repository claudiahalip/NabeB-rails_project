module UsersHelper
    def display_username_header
        if current_user
            "You are logged in as  #{current_user.username}"
        
        end
    end 

end
