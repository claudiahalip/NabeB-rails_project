module BusinessesHelper

    def display_businesses_header(neighborhood)
        if neighborhood
            "All the businesses in #{neighborhood.name}"
        else 
            "All Businesses"
        end
    end 


    def display_edit_business(business)
        if current_user.id == business.user_id
            link_to "Edit", edit_business_path 
           
        end
    end 

    def display_delete_business(business)
        if current_user.id == business.user_id
            link_to "Delete business", business_path, method: "DELETE"
        end
    end 
end

