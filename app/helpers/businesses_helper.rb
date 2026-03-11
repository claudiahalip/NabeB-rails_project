module BusinessesHelper

    def display_businesses_header(neighborhood)
        if neighborhood
            "All the businesses in #{neighborhood.name}"
        else 
            "All Businesses"
        end
    end 


    def display_edit_business(business)
        if logged_in? && current_user == business.user
            link_to "Edit", edit_business_path(business)
        end
    end

    def display_delete_business(business)
        if logged_in? && current_user == business.user
            link_to "Delete business", business_path(business), method: "DELETE", data: { confirm: 'Are you sure you want to delete this business?' }
        end
    end
end

