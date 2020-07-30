module BusinessesHelper

    def display_businesses_header(neighborhood)
        if neighborhood
            "All the businesses in #{neighborhood.name}"
        else 
            "All Businesses"
        end
    end 
end
