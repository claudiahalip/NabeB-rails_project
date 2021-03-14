module UsersHelper
    def display_username_header
        if current_user
            "Welcome  #{current_user.username}!"
        end
    end 

end
